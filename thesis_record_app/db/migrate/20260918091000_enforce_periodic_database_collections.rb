class EnforcePeriodicDatabaseCollections < ActiveRecord::Migration[7.2]
  BASELINE_TABLES = %w[
    data_sources source_access_paths intake_manifests schema_versions metric_definitions
    metric_observations metric_quality_reviews susb_public_file_rows bfs_api_rows bds_public_file_rows
  ].freeze
  SOURCE_TABLES = %w[susb_public_file_rows bds_public_file_rows bfs_api_rows].freeze
  OPERATIONAL_TABLES = %w[
    day_zero_registrations periodic_captures periodic_source_checks quarterly_result_sets
    quarterly_collections quarterly_collection_captures
  ].freeze

  def up
    create_functions
    BASELINE_TABLES.each do |table|
      execute "CREATE TRIGGER periodic_baseline_guard BEFORE UPDATE OR DELETE ON #{table} FOR EACH ROW EXECUTE FUNCTION periodic_guard_member()"
      execute "CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON #{table} FOR EACH STATEMENT EXECUTE FUNCTION periodic_guard_truncate()"
    end
    (SOURCE_TABLES + %w[metric_observations]).each do |table|
      execute "CREATE TRIGGER periodic_insert_guard BEFORE INSERT ON #{table} FOR EACH ROW EXECUTE FUNCTION periodic_guard_insert()"
    end
    execute "CREATE TRIGGER periodic_review_insert_guard BEFORE INSERT ON metric_quality_reviews FOR EACH ROW EXECUTE FUNCTION periodic_guard_review_insert()"
    (OPERATIONAL_TABLES + BASELINE_TABLES).uniq.each do |table|
      execute "CREATE TRIGGER periodic_operational_truncate BEFORE TRUNCATE ON #{table} FOR EACH STATEMENT EXECUTE FUNCTION periodic_guard_truncate()" unless BASELINE_TABLES.include?(table)
    end
    OPERATIONAL_TABLES.each do |table|
      execute "CREATE TRIGGER periodic_operational_delete BEFORE DELETE ON #{table} FOR EACH ROW EXECUTE FUNCTION periodic_reject_delete()"
    end
    %w[day_zero_registrations periodic_source_checks quarterly_collection_captures].each do |table|
      execute "CREATE TRIGGER periodic_immutable_update BEFORE UPDATE ON #{table} FOR EACH ROW EXECUTE FUNCTION periodic_reject_update()"
    end
    %w[periodic_captures quarterly_result_sets quarterly_collections].each do |table|
      execute "CREATE TRIGGER periodic_completed_update BEFORE UPDATE ON #{table} FOR EACH ROW EXECUTE FUNCTION periodic_guard_completed()"
    end
    execute "CREATE TRIGGER periodic_capture_complete BEFORE UPDATE ON periodic_captures FOR EACH ROW EXECUTE FUNCTION periodic_verify_capture_count()"
    execute "CREATE TRIGGER periodic_result_complete BEFORE UPDATE ON quarterly_result_sets FOR EACH ROW EXECUTE FUNCTION periodic_verify_result_count()"
    execute "CREATE TRIGGER periodic_collection_complete BEFORE UPDATE ON quarterly_collections FOR EACH ROW EXECUTE FUNCTION periodic_verify_collection()"
    execute "CREATE TRIGGER periodic_membership_insert BEFORE INSERT ON quarterly_collection_captures FOR EACH ROW EXECUTE FUNCTION periodic_guard_membership_insert()"
    execute "CREATE TRIGGER periodic_check_insert BEFORE INSERT ON periodic_source_checks FOR EACH ROW EXECUTE FUNCTION periodic_guard_check_insert()"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "collection protection cannot be removed after registration"
  end

  private

  def create_functions
    execute <<~SQL
      CREATE FUNCTION periodic_reject_delete() RETURNS trigger LANGUAGE plpgsql AS $$
      BEGIN
        RAISE EXCEPTION 'periodic records are append-only';
      END;
      $$;

      CREATE FUNCTION periodic_reject_update() RETURNS trigger LANGUAGE plpgsql AS $$
      BEGIN
        RAISE EXCEPTION 'periodic identity or membership is immutable';
      END;
      $$;

      CREATE FUNCTION periodic_guard_truncate() RETURNS trigger LANGUAGE plpgsql AS $$
      BEGIN
        IF TG_TABLE_NAME IN ('day_zero_registrations', 'periodic_captures', 'periodic_source_checks',
                             'quarterly_result_sets', 'quarterly_collections', 'quarterly_collection_captures')
           OR EXISTS (SELECT 1 FROM day_zero_registrations) THEN
          RAISE EXCEPTION 'registered evidence cannot be truncated';
        END IF;
        RETURN NULL;
      END;
      $$;

      CREATE FUNCTION periodic_guard_member() RETURNS trigger LANGUAGE plpgsql AS $$
      DECLARE
        captured_id bigint;
        result_id bigint;
      BEGIN
        IF TG_TABLE_NAME IN ('data_sources', 'intake_manifests', 'schema_versions', 'metric_definitions')
           AND EXISTS (SELECT 1 FROM day_zero_registrations) THEN
          RAISE EXCEPTION 'registered source and definition records are append-only';
        END IF;
        IF EXISTS (
          SELECT 1 FROM day_zero_registrations registration,
          LATERAL jsonb_array_elements(registration.manifest->'tables'->TG_TABLE_NAME->'member_id_ranges') bounds
          WHERE OLD.id BETWEEN (bounds->>0)::bigint AND (bounds->>1)::bigint
        ) THEN
          RAISE EXCEPTION 'Day 0 member is immutable';
        END IF;

        IF TG_TABLE_NAME IN ('susb_public_file_rows', 'bds_public_file_rows', 'bfs_api_rows') THEN
          captured_id := OLD.periodic_capture_id;
          IF captured_id IS NOT NULL THEN
            RAISE EXCEPTION 'periodic source row is immutable';
          END IF;
        ELSIF TG_TABLE_NAME = 'metric_observations' THEN
          result_id := OLD.quarterly_result_set_id;
          IF result_id IS NOT NULL THEN
            RAISE EXCEPTION 'periodic observation is immutable';
          END IF;
        ELSIF TG_TABLE_NAME = 'metric_quality_reviews' THEN
          SELECT quarterly_result_set_id INTO result_id FROM metric_observations
            WHERE id = OLD.metric_observation_id;
          IF result_id IS NOT NULL THEN
            RAISE EXCEPTION 'periodic review is immutable';
          END IF;
        END IF;
        IF TG_OP = 'UPDATE' THEN RETURN NEW; END IF;
        RETURN OLD;
      END;
      $$;

      CREATE FUNCTION periodic_guard_insert() RETURNS trigger LANGUAGE plpgsql AS $$
      DECLARE
        capture_status text;
        capture_source bigint;
        result_status text;
        captured_id bigint;
        result_id bigint;
      BEGIN
        IF TG_TABLE_NAME = 'metric_observations' THEN
          result_id := NEW.quarterly_result_set_id;
          IF result_id IS NULL AND EXISTS (SELECT 1 FROM day_zero_registrations) THEN
            RAISE EXCEPTION 'new observations require a quarterly result set';
          END IF;
          IF result_id IS NOT NULL THEN
            SELECT status INTO result_status FROM quarterly_result_sets WHERE id = result_id FOR UPDATE;
            IF result_status IS DISTINCT FROM 'building' THEN
              RAISE EXCEPTION 'result set is not open for observations';
            END IF;
          END IF;
        ELSE
          captured_id := NEW.periodic_capture_id;
          IF captured_id IS NULL AND EXISTS (SELECT 1 FROM day_zero_registrations) THEN
            RAISE EXCEPTION 'new source rows require a periodic capture';
          END IF;
          IF captured_id IS NOT NULL THEN
            SELECT status, data_source_id INTO capture_status, capture_source
              FROM periodic_captures WHERE id = captured_id FOR UPDATE;
            IF capture_status IS DISTINCT FROM 'loading' OR capture_source IS DISTINCT FROM NEW.data_source_id THEN
              RAISE EXCEPTION 'capture is not open for this source row';
            END IF;
          END IF;
        END IF;
        RETURN NEW;
      END;
      $$;

      CREATE FUNCTION periodic_guard_review_insert() RETURNS trigger LANGUAGE plpgsql AS $$
      DECLARE
        result_id bigint;
        result_status text;
      BEGIN
        SELECT quarterly_result_set_id INTO result_id FROM metric_observations
          WHERE id = NEW.metric_observation_id;
        IF result_id IS NULL AND EXISTS (SELECT 1 FROM day_zero_registrations) THEN
          RAISE EXCEPTION 'new reviews require a quarterly observation';
        END IF;
        IF result_id IS NOT NULL THEN
          SELECT status INTO result_status FROM quarterly_result_sets WHERE id = result_id FOR UPDATE;
          IF result_status IS DISTINCT FROM 'building' THEN
            RAISE EXCEPTION 'result set is not open for reviews';
          END IF;
        END IF;
        RETURN NEW;
      END;
      $$;

      CREATE FUNCTION periodic_guard_completed() RETURNS trigger LANGUAGE plpgsql AS $$
      BEGIN
        IF OLD.status = 'completed' THEN
          RAISE EXCEPTION 'completed periodic record is immutable';
        END IF;
        IF TG_TABLE_NAME = 'periodic_captures' THEN
          IF ROW(NEW.data_source_id, NEW.dataset_scope, NEW.release_identity,
                 NEW.response_sha256, NEW.parser_version, NEW.retrieved_at)
             IS DISTINCT FROM
             ROW(OLD.data_source_id, OLD.dataset_scope, OLD.release_identity,
                 OLD.response_sha256, OLD.parser_version, OLD.retrieved_at) THEN
            RAISE EXCEPTION 'capture identity is immutable';
          END IF;
        ELSIF TG_TABLE_NAME = 'quarterly_result_sets' THEN
          IF ROW(NEW.input_digest, NEW.method_digest, NEW.definition_digest,
                 NEW.identity_digest, NEW.method_manifest)
             IS DISTINCT FROM
             ROW(OLD.input_digest, OLD.method_digest, OLD.definition_digest,
                 OLD.identity_digest, OLD.method_manifest) THEN
            RAISE EXCEPTION 'result identity is immutable';
          END IF;
        ELSIF TG_TABLE_NAME = 'quarterly_collections' THEN
          IF ROW(NEW.quarter, NEW.revision, NEW.identity_digest, NEW.input_digest,
                 NEW.quarterly_result_set_id, NEW.cutoff_at)
             IS DISTINCT FROM
             ROW(OLD.quarter, OLD.revision, OLD.identity_digest, OLD.input_digest,
                 OLD.quarterly_result_set_id, OLD.cutoff_at) THEN
            RAISE EXCEPTION 'quarter identity is immutable';
          END IF;
        END IF;
        RETURN NEW;
      END;
      $$;

      CREATE FUNCTION periodic_verify_capture_count() RETURNS trigger LANGUAGE plpgsql AS $$
      DECLARE
        source_kind text;
        table_name text;
        actual_count bigint;
      BEGIN
        IF NEW.status <> 'completed' OR OLD.status = 'completed' THEN RETURN NEW; END IF;
        SELECT data_sources.source_kind INTO source_kind FROM data_sources WHERE id = NEW.data_source_id;
        table_name := CASE source_kind
          WHEN 'census_susb_public_file' THEN 'susb_public_file_rows'
          WHEN 'census_bds_public_file' THEN 'bds_public_file_rows'
          WHEN 'census_bfs_api' THEN 'bfs_api_rows'
          ELSE NULL END;
        IF table_name IS NULL THEN RAISE EXCEPTION 'unsupported periodic source kind'; END IF;
        EXECUTE format('SELECT count(*) FROM %I WHERE periodic_capture_id = $1', table_name)
          INTO actual_count USING NEW.id;
        IF actual_count = 0 OR actual_count <> NEW.row_count THEN
          RAISE EXCEPTION 'capture row count mismatch';
        END IF;
        RETURN NEW;
      END;
      $$;

      CREATE FUNCTION periodic_verify_result_count() RETURNS trigger LANGUAGE plpgsql AS $$
      DECLARE
        actual_observations bigint;
        actual_reviews bigint;
      BEGIN
        IF NEW.status <> 'completed' OR OLD.status = 'completed' THEN RETURN NEW; END IF;
        SELECT count(*) INTO actual_observations FROM metric_observations
          WHERE quarterly_result_set_id = NEW.id;
        SELECT count(*) INTO actual_reviews FROM metric_quality_reviews reviews
          JOIN metric_observations observations ON observations.id = reviews.metric_observation_id
          WHERE observations.quarterly_result_set_id = NEW.id;
        IF actual_observations = 0 OR actual_observations <> NEW.observation_count OR actual_reviews <> NEW.review_count
           OR actual_observations <> actual_reviews THEN
          RAISE EXCEPTION 'result set review coverage mismatch';
        END IF;
        RETURN NEW;
      END;
      $$;

      CREATE FUNCTION periodic_verify_collection() RETURNS trigger LANGUAGE plpgsql AS $$
      DECLARE
        result_status text;
      BEGIN
        IF NEW.status <> 'completed' OR OLD.status = 'completed' THEN RETURN NEW; END IF;
        SELECT status INTO result_status FROM quarterly_result_sets
          WHERE id = NEW.quarterly_result_set_id;
        IF result_status IS DISTINCT FROM 'completed' OR NOT EXISTS (
          SELECT 1 FROM quarterly_collection_captures WHERE quarterly_collection_id = NEW.id
        ) THEN
          RAISE EXCEPTION 'quarter cannot complete without captures and results';
        END IF;
        RETURN NEW;
      END;
      $$;

      CREATE FUNCTION periodic_guard_membership_insert() RETURNS trigger LANGUAGE plpgsql AS $$
      DECLARE
        collection_status text;
        capture_status text;
      BEGIN
        SELECT status INTO collection_status FROM quarterly_collections
          WHERE id = NEW.quarterly_collection_id FOR UPDATE;
        SELECT status INTO capture_status FROM periodic_captures
          WHERE id = NEW.periodic_capture_id;
        IF collection_status IS DISTINCT FROM 'building' OR capture_status IS DISTINCT FROM 'completed' THEN
          RAISE EXCEPTION 'quarter membership requires an open quarter and completed capture';
        END IF;
        RETURN NEW;
      END;
      $$;

      CREATE FUNCTION periodic_guard_check_insert() RETURNS trigger LANGUAGE plpgsql AS $$
      DECLARE
        capture_status text;
        capture_source bigint;
        capture_scope text;
        capture_release text;
      BEGIN
        IF NEW.status = 'failed' THEN RETURN NEW; END IF;
        SELECT status, data_source_id, dataset_scope, release_identity
          INTO capture_status, capture_source, capture_scope, capture_release
          FROM periodic_captures WHERE id = NEW.periodic_capture_id;
        IF capture_status IS DISTINCT FROM 'completed' OR
           capture_source IS DISTINCT FROM NEW.data_source_id OR
           capture_scope IS DISTINCT FROM NEW.dataset_scope OR
           capture_release IS DISTINCT FROM NEW.release_identity THEN
          RAISE EXCEPTION 'successful check requires a matching completed capture';
        END IF;
        RETURN NEW;
      END;
      $$;
    SQL
  end
end
