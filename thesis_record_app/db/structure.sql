SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: periodic_guard_check_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_guard_check_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


--
-- Name: periodic_guard_completed(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_guard_completed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


--
-- Name: periodic_guard_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_guard_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


--
-- Name: periodic_guard_member(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_guard_member() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


--
-- Name: periodic_guard_membership_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_guard_membership_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


--
-- Name: periodic_guard_review_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_guard_review_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


--
-- Name: periodic_guard_truncate(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_guard_truncate() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF TG_TABLE_NAME IN ('day_zero_registrations', 'periodic_captures', 'periodic_source_checks',
                       'quarterly_result_sets', 'quarterly_collections', 'quarterly_collection_captures')
     OR EXISTS (SELECT 1 FROM day_zero_registrations) THEN
    RAISE EXCEPTION 'registered evidence cannot be truncated';
  END IF;
  RETURN NULL;
END;
$$;


--
-- Name: periodic_reject_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_reject_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  RAISE EXCEPTION 'periodic records are append-only';
END;
$$;


--
-- Name: periodic_reject_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_reject_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  RAISE EXCEPTION 'periodic identity or membership is immutable';
END;
$$;


--
-- Name: periodic_verify_capture_count(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_verify_capture_count() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
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
$_$;


--
-- Name: periodic_verify_collection(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_verify_collection() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


--
-- Name: periodic_verify_result_count(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.periodic_verify_result_count() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: audit_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_events (
    id bigint NOT NULL,
    occurred_at timestamp(6) without time zone NOT NULL,
    actor_type character varying NOT NULL,
    actor_id character varying,
    event_type character varying NOT NULL,
    entity_type character varying NOT NULL,
    entity_id character varying NOT NULL,
    source_id character varying,
    snapshot_id character varying,
    request_id character varying,
    job_id character varying,
    previous_state_hash character varying,
    new_state_hash character varying,
    change_summary text NOT NULL,
    reason_code character varying NOT NULL,
    review_required boolean DEFAULT false NOT NULL,
    review_id character varying,
    storage_zone character varying NOT NULL,
    privacy_classification character varying NOT NULL,
    claim_status_effect character varying DEFAULT 'unchanged'::character varying NOT NULL,
    export_allowed boolean DEFAULT false NOT NULL,
    ip_or_host character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: audit_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_events_id_seq OWNED BY public.audit_events.id;


--
-- Name: bds_public_file_rows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bds_public_file_rows (
    id bigint NOT NULL,
    data_source_id bigint NOT NULL,
    intake_manifest_id bigint NOT NULL,
    schema_version_id bigint NOT NULL,
    source_row_number integer NOT NULL,
    year integer NOT NULL,
    sector_code character varying NOT NULL,
    firm_age_code character varying NOT NULL,
    firm_size_code character varying NOT NULL,
    raw_measure_values jsonb DEFAULT '{}'::jsonb NOT NULL,
    numeric_measure_values jsonb DEFAULT '{}'::jsonb NOT NULL,
    publication_flags jsonb DEFAULT '{}'::jsonb NOT NULL,
    row_hash character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    periodic_capture_id bigint
);


--
-- Name: bds_public_file_rows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bds_public_file_rows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bds_public_file_rows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bds_public_file_rows_id_seq OWNED BY public.bds_public_file_rows.id;


--
-- Name: bfs_api_rows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bfs_api_rows (
    id bigint NOT NULL,
    data_source_id bigint NOT NULL,
    intake_manifest_id bigint NOT NULL,
    schema_version_id bigint NOT NULL,
    period_month character varying NOT NULL,
    year integer NOT NULL,
    month integer NOT NULL,
    data_type_code character varying NOT NULL,
    time_slot_id character varying NOT NULL,
    seasonally_adj character varying NOT NULL,
    category_code character varying NOT NULL,
    geography_level character varying NOT NULL,
    geography_code character varying NOT NULL,
    cell_value_raw character varying NOT NULL,
    cell_value_numeric numeric(20,6),
    error_data character varying NOT NULL,
    row_hash character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    periodic_capture_id bigint
);


--
-- Name: bfs_api_rows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bfs_api_rows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bfs_api_rows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bfs_api_rows_id_seq OWNED BY public.bfs_api_rows.id;


--
-- Name: claim_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.claim_reviews (
    id bigint NOT NULL,
    prediction_link_id bigint,
    claim_id character varying NOT NULL,
    review_status character varying DEFAULT 'review_pending'::character varying NOT NULL,
    prior_status character varying NOT NULL,
    proposed_status character varying NOT NULL,
    reason_code character varying NOT NULL,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: claim_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.claim_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: claim_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.claim_reviews_id_seq OWNED BY public.claim_reviews.id;


--
-- Name: data_sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.data_sources (
    id bigint NOT NULL,
    name character varying NOT NULL,
    source_kind character varying NOT NULL,
    source_status character varying DEFAULT 'source_registered'::character varying NOT NULL,
    storage_zone character varying NOT NULL,
    privacy_classification character varying NOT NULL,
    public_repo_allowed boolean DEFAULT false NOT NULL,
    structured_private_allowed boolean DEFAULT true NOT NULL,
    private_file_storage_allowed boolean DEFAULT false NOT NULL,
    secret_material_present boolean DEFAULT false NOT NULL,
    redaction_required boolean DEFAULT true NOT NULL,
    minimum_cell_rule_required boolean DEFAULT true NOT NULL,
    human_review_required boolean DEFAULT true NOT NULL,
    retention_rule character varying NOT NULL,
    claim_status_allowed character varying DEFAULT 'not_evidence'::character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: data_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.data_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: data_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.data_sources_id_seq OWNED BY public.data_sources.id;


--
-- Name: day_zero_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.day_zero_registrations (
    id bigint NOT NULL,
    baseline_key character varying NOT NULL,
    baseline_observed_on date NOT NULL,
    manifest_digest character varying NOT NULL,
    manifest jsonb NOT NULL,
    verified_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: day_zero_registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.day_zero_registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: day_zero_registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.day_zero_registrations_id_seq OWNED BY public.day_zero_registrations.id;


--
-- Name: evidence_snapshots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evidence_snapshots (
    id bigint NOT NULL,
    version_label character varying NOT NULL,
    snapshot_status character varying NOT NULL,
    frozen_at timestamp(6) without time zone NOT NULL,
    commit_sha character varying,
    manifest jsonb DEFAULT '{}'::jsonb NOT NULL,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: evidence_snapshots_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.evidence_snapshots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evidence_snapshots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.evidence_snapshots_id_seq OWNED BY public.evidence_snapshots.id;


--
-- Name: export_artifacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.export_artifacts (
    id bigint NOT NULL,
    evidence_snapshot_id bigint,
    artifact_kind character varying NOT NULL,
    export_status character varying DEFAULT 'draft'::character varying NOT NULL,
    privacy_review_status character varying DEFAULT 'pending'::character varying NOT NULL,
    reviewed_for_public_repo boolean DEFAULT false NOT NULL,
    artifact_path character varying,
    content_hash character varying,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: export_artifacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.export_artifacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: export_artifacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.export_artifacts_id_seq OWNED BY public.export_artifacts.id;


--
-- Name: failure_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.failure_records (
    id bigint NOT NULL,
    prediction_link_id bigint,
    audit_event_id bigint,
    prediction_id character varying NOT NULL,
    horizon character varying NOT NULL,
    failure_type character varying NOT NULL,
    evidence_object_id character varying,
    source_status character varying,
    metric_status character varying NOT NULL,
    observed_direction character varying NOT NULL,
    expected_direction character varying NOT NULL,
    failure_condition_triggered boolean DEFAULT false NOT NULL,
    alternative_explanation text,
    business_cycle_context text,
    company_case_scope character varying,
    human_review_status character varying DEFAULT 'pending'::character varying NOT NULL,
    publication_status character varying DEFAULT 'not_public'::character varying NOT NULL,
    revision_action character varying DEFAULT 'none'::character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: failure_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failure_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: failure_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failure_records_id_seq OWNED BY public.failure_records.id;


--
-- Name: intake_manifests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.intake_manifests (
    id bigint NOT NULL,
    data_source_id bigint NOT NULL,
    name character varying NOT NULL,
    manifest_status character varying DEFAULT 'empty_manifest'::character varying NOT NULL,
    storage_zone character varying NOT NULL,
    privacy_classification character varying NOT NULL,
    public_repo_allowed boolean DEFAULT false NOT NULL,
    structured_private_allowed boolean DEFAULT true NOT NULL,
    private_file_storage_allowed boolean DEFAULT false NOT NULL,
    secret_material_present boolean DEFAULT false NOT NULL,
    redaction_required boolean DEFAULT true NOT NULL,
    minimum_cell_rule_required boolean DEFAULT true NOT NULL,
    human_review_required boolean DEFAULT true NOT NULL,
    retention_rule character varying NOT NULL,
    field_map jsonb DEFAULT '{}'::jsonb NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: intake_manifests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.intake_manifests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: intake_manifests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.intake_manifests_id_seq OWNED BY public.intake_manifests.id;


--
-- Name: metric_definitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metric_definitions (
    id bigint NOT NULL,
    key character varying NOT NULL,
    name character varying NOT NULL,
    formula_status character varying DEFAULT 'draft'::character varying NOT NULL,
    formula text,
    limitations text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: metric_definitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metric_definitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: metric_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.metric_definitions_id_seq OWNED BY public.metric_definitions.id;


--
-- Name: metric_observations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metric_observations (
    id bigint NOT NULL,
    metric_definition_id bigint NOT NULL,
    data_source_id bigint,
    period character varying NOT NULL,
    metric_status character varying NOT NULL,
    numeric_value numeric(20,6),
    unit character varying,
    dimensions jsonb DEFAULT '{}'::jsonb NOT NULL,
    quality_metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    quarterly_result_set_id bigint,
    result_row_key character varying,
    CONSTRAINT metric_observations_result_key_presence CHECK ((((quarterly_result_set_id IS NULL) AND (result_row_key IS NULL)) OR ((quarterly_result_set_id IS NOT NULL) AND (result_row_key IS NOT NULL))))
);


--
-- Name: metric_observations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metric_observations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: metric_observations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.metric_observations_id_seq OWNED BY public.metric_observations.id;


--
-- Name: metric_quality_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.metric_quality_reviews (
    id bigint NOT NULL,
    metric_observation_id bigint NOT NULL,
    data_source_id bigint,
    policy_version character varying NOT NULL,
    source_metric_status character varying NOT NULL,
    review_status character varying NOT NULL,
    review_reason_code character varying NOT NULL,
    reviewed_by character varying NOT NULL,
    reviewed_at timestamp(6) without time zone NOT NULL,
    review_metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: metric_quality_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.metric_quality_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: metric_quality_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.metric_quality_reviews_id_seq OWNED BY public.metric_quality_reviews.id;


--
-- Name: periodic_captures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.periodic_captures (
    id bigint NOT NULL,
    data_source_id bigint NOT NULL,
    dataset_scope character varying NOT NULL,
    release_identity character varying NOT NULL,
    response_sha256 character varying NOT NULL,
    parsed_rows_digest character varying NOT NULL,
    parser_version character varying NOT NULL,
    row_count bigint NOT NULL,
    status character varying DEFAULT 'loading'::character varying NOT NULL,
    retrieved_at timestamp(6) without time zone NOT NULL,
    completed_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT periodic_captures_completion CHECK (((((status)::text = 'loading'::text) AND (completed_at IS NULL)) OR (((status)::text = 'completed'::text) AND (completed_at IS NOT NULL)))),
    CONSTRAINT periodic_captures_nonnegative_count CHECK ((row_count >= 0)),
    CONSTRAINT periodic_captures_status CHECK (((status)::text = ANY ((ARRAY['loading'::character varying, 'completed'::character varying])::text[])))
);


--
-- Name: periodic_captures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.periodic_captures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: periodic_captures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.periodic_captures_id_seq OWNED BY public.periodic_captures.id;


--
-- Name: periodic_source_checks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.periodic_source_checks (
    id bigint NOT NULL,
    data_source_id bigint NOT NULL,
    periodic_capture_id bigint,
    dataset_scope character varying NOT NULL,
    release_identity character varying NOT NULL,
    status character varying NOT NULL,
    error_class character varying,
    checked_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT periodic_source_checks_capture_presence CHECK (((((status)::text = 'failed'::text) AND (periodic_capture_id IS NULL)) OR (((status)::text <> 'failed'::text) AND (periodic_capture_id IS NOT NULL)))),
    CONSTRAINT periodic_source_checks_status CHECK (((status)::text = ANY ((ARRAY['new'::character varying, 'unchanged'::character varying, 'failed'::character varying])::text[])))
);


--
-- Name: periodic_source_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.periodic_source_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: periodic_source_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.periodic_source_checks_id_seq OWNED BY public.periodic_source_checks.id;


--
-- Name: prediction_links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prediction_links (
    id bigint NOT NULL,
    metric_observation_id bigint,
    data_source_id bigint,
    prediction_id character varying NOT NULL,
    evidence_classification character varying NOT NULL,
    review_status character varying DEFAULT 'review_pending'::character varying NOT NULL,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: prediction_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prediction_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prediction_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prediction_links_id_seq OWNED BY public.prediction_links.id;


--
-- Name: privacy_reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.privacy_reviews (
    id bigint NOT NULL,
    data_source_id bigint,
    intake_manifest_id bigint,
    review_status character varying NOT NULL,
    privacy_classification character varying NOT NULL,
    reviewed_by character varying NOT NULL,
    identity_fields_removed boolean DEFAULT false NOT NULL,
    client_confidentiality_reviewed boolean DEFAULT false NOT NULL,
    worker_or_evaluator_confidentiality_reviewed boolean DEFAULT false NOT NULL,
    hidden_labor_reviewed boolean DEFAULT false NOT NULL,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: privacy_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.privacy_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: privacy_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.privacy_reviews_id_seq OWNED BY public.privacy_reviews.id;


--
-- Name: private_artifacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.private_artifacts (
    id bigint NOT NULL,
    data_source_id bigint,
    artifact_kind character varying NOT NULL,
    storage_zone character varying NOT NULL,
    privacy_classification character varying NOT NULL,
    public_repo_allowed boolean DEFAULT false NOT NULL,
    structured_private_allowed boolean DEFAULT false NOT NULL,
    private_file_storage_allowed boolean DEFAULT true NOT NULL,
    secret_material_present boolean DEFAULT false NOT NULL,
    redaction_required boolean DEFAULT true NOT NULL,
    minimum_cell_rule_required boolean DEFAULT true NOT NULL,
    human_review_required boolean DEFAULT true NOT NULL,
    storage_pointer character varying NOT NULL,
    content_hash character varying NOT NULL,
    retention_rule character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: private_artifacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.private_artifacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: private_artifacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.private_artifacts_id_seq OWNED BY public.private_artifacts.id;


--
-- Name: quality_flags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quality_flags (
    id bigint NOT NULL,
    metric_observation_id bigint,
    data_source_id bigint,
    flag_type character varying NOT NULL,
    status character varying DEFAULT 'open'::character varying NOT NULL,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: quality_flags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quality_flags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quality_flags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quality_flags_id_seq OWNED BY public.quality_flags.id;


--
-- Name: quarterly_collection_captures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quarterly_collection_captures (
    id bigint NOT NULL,
    quarterly_collection_id bigint NOT NULL,
    periodic_capture_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: quarterly_collection_captures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quarterly_collection_captures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quarterly_collection_captures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quarterly_collection_captures_id_seq OWNED BY public.quarterly_collection_captures.id;


--
-- Name: quarterly_collections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quarterly_collections (
    id bigint NOT NULL,
    quarter character varying NOT NULL,
    revision integer NOT NULL,
    identity_digest character varying NOT NULL,
    input_digest character varying NOT NULL,
    quarterly_result_set_id bigint,
    status character varying DEFAULT 'building'::character varying NOT NULL,
    cutoff_at timestamp(6) without time zone NOT NULL,
    completed_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT quarterly_collections_completion CHECK (((((status)::text = 'building'::text) AND (completed_at IS NULL)) OR (((status)::text = 'completed'::text) AND (completed_at IS NOT NULL) AND (quarterly_result_set_id IS NOT NULL)))),
    CONSTRAINT quarterly_collections_quarter_format CHECK (((quarter)::text ~ '^[0-9]{4}-Q[1-4]$'::text)),
    CONSTRAINT quarterly_collections_revision CHECK ((revision > 0)),
    CONSTRAINT quarterly_collections_status CHECK (((status)::text = ANY ((ARRAY['building'::character varying, 'completed'::character varying])::text[])))
);


--
-- Name: quarterly_collections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quarterly_collections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quarterly_collections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quarterly_collections_id_seq OWNED BY public.quarterly_collections.id;


--
-- Name: quarterly_result_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quarterly_result_sets (
    id bigint NOT NULL,
    input_digest character varying NOT NULL,
    method_digest character varying NOT NULL,
    definition_digest character varying NOT NULL,
    identity_digest character varying NOT NULL,
    method_manifest jsonb NOT NULL,
    status character varying DEFAULT 'building'::character varying NOT NULL,
    observation_count bigint,
    review_count bigint,
    completed_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT quarterly_result_sets_completion CHECK (((((status)::text = 'building'::text) AND (completed_at IS NULL)) OR (((status)::text = 'completed'::text) AND (completed_at IS NOT NULL) AND (observation_count = review_count)))),
    CONSTRAINT quarterly_result_sets_status CHECK (((status)::text = ANY ((ARRAY['building'::character varying, 'completed'::character varying])::text[])))
);


--
-- Name: quarterly_result_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quarterly_result_sets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quarterly_result_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quarterly_result_sets_id_seq OWNED BY public.quarterly_result_sets.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: schema_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_versions (
    id bigint NOT NULL,
    data_source_id bigint,
    intake_manifest_id bigint,
    version character varying NOT NULL,
    schema_status character varying DEFAULT 'draft'::character varying NOT NULL,
    schema jsonb DEFAULT '{}'::jsonb NOT NULL,
    notes text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: schema_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.schema_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schema_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.schema_versions_id_seq OWNED BY public.schema_versions.id;


--
-- Name: source_access_paths; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.source_access_paths (
    id bigint NOT NULL,
    data_source_id bigint NOT NULL,
    access_type character varying NOT NULL,
    uri_or_reference text NOT NULL,
    status character varying NOT NULL,
    last_checked_at timestamp(6) without time zone,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: source_access_paths_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.source_access_paths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: source_access_paths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.source_access_paths_id_seq OWNED BY public.source_access_paths.id;


--
-- Name: susb_public_file_rows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.susb_public_file_rows (
    id bigint NOT NULL,
    data_source_id bigint NOT NULL,
    intake_manifest_id bigint NOT NULL,
    schema_version_id bigint NOT NULL,
    year integer NOT NULL,
    state_code character varying NOT NULL,
    naics_code character varying NOT NULL,
    enterprise_size_code character varying NOT NULL,
    firm_count bigint NOT NULL,
    establishment_count bigint NOT NULL,
    employment bigint NOT NULL,
    employment_noise_flag character varying NOT NULL,
    annual_payroll_thousand bigint NOT NULL,
    payroll_noise_flag character varying NOT NULL,
    receipts_thousand bigint,
    receipts_noise_flag character varying,
    state_name character varying NOT NULL,
    naics_description text NOT NULL,
    enterprise_size_description character varying NOT NULL,
    row_hash character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    periodic_capture_id bigint
);


--
-- Name: susb_public_file_rows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.susb_public_file_rows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: susb_public_file_rows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.susb_public_file_rows_id_seq OWNED BY public.susb_public_file_rows.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    role_id bigint,
    email character varying NOT NULL,
    password_digest character varying,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: audit_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_events ALTER COLUMN id SET DEFAULT nextval('public.audit_events_id_seq'::regclass);


--
-- Name: bds_public_file_rows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bds_public_file_rows ALTER COLUMN id SET DEFAULT nextval('public.bds_public_file_rows_id_seq'::regclass);


--
-- Name: bfs_api_rows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bfs_api_rows ALTER COLUMN id SET DEFAULT nextval('public.bfs_api_rows_id_seq'::regclass);


--
-- Name: claim_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claim_reviews ALTER COLUMN id SET DEFAULT nextval('public.claim_reviews_id_seq'::regclass);


--
-- Name: data_sources id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_sources ALTER COLUMN id SET DEFAULT nextval('public.data_sources_id_seq'::regclass);


--
-- Name: day_zero_registrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.day_zero_registrations ALTER COLUMN id SET DEFAULT nextval('public.day_zero_registrations_id_seq'::regclass);


--
-- Name: evidence_snapshots id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evidence_snapshots ALTER COLUMN id SET DEFAULT nextval('public.evidence_snapshots_id_seq'::regclass);


--
-- Name: export_artifacts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.export_artifacts ALTER COLUMN id SET DEFAULT nextval('public.export_artifacts_id_seq'::regclass);


--
-- Name: failure_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failure_records ALTER COLUMN id SET DEFAULT nextval('public.failure_records_id_seq'::regclass);


--
-- Name: intake_manifests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intake_manifests ALTER COLUMN id SET DEFAULT nextval('public.intake_manifests_id_seq'::regclass);


--
-- Name: metric_definitions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_definitions ALTER COLUMN id SET DEFAULT nextval('public.metric_definitions_id_seq'::regclass);


--
-- Name: metric_observations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_observations ALTER COLUMN id SET DEFAULT nextval('public.metric_observations_id_seq'::regclass);


--
-- Name: metric_quality_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_quality_reviews ALTER COLUMN id SET DEFAULT nextval('public.metric_quality_reviews_id_seq'::regclass);


--
-- Name: periodic_captures id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodic_captures ALTER COLUMN id SET DEFAULT nextval('public.periodic_captures_id_seq'::regclass);


--
-- Name: periodic_source_checks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodic_source_checks ALTER COLUMN id SET DEFAULT nextval('public.periodic_source_checks_id_seq'::regclass);


--
-- Name: prediction_links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prediction_links ALTER COLUMN id SET DEFAULT nextval('public.prediction_links_id_seq'::regclass);


--
-- Name: privacy_reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_reviews ALTER COLUMN id SET DEFAULT nextval('public.privacy_reviews_id_seq'::regclass);


--
-- Name: private_artifacts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.private_artifacts ALTER COLUMN id SET DEFAULT nextval('public.private_artifacts_id_seq'::regclass);


--
-- Name: quality_flags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quality_flags ALTER COLUMN id SET DEFAULT nextval('public.quality_flags_id_seq'::regclass);


--
-- Name: quarterly_collection_captures id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quarterly_collection_captures ALTER COLUMN id SET DEFAULT nextval('public.quarterly_collection_captures_id_seq'::regclass);


--
-- Name: quarterly_collections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quarterly_collections ALTER COLUMN id SET DEFAULT nextval('public.quarterly_collections_id_seq'::regclass);


--
-- Name: quarterly_result_sets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quarterly_result_sets ALTER COLUMN id SET DEFAULT nextval('public.quarterly_result_sets_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: schema_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_versions ALTER COLUMN id SET DEFAULT nextval('public.schema_versions_id_seq'::regclass);


--
-- Name: source_access_paths id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.source_access_paths ALTER COLUMN id SET DEFAULT nextval('public.source_access_paths_id_seq'::regclass);


--
-- Name: susb_public_file_rows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.susb_public_file_rows ALTER COLUMN id SET DEFAULT nextval('public.susb_public_file_rows_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: audit_events audit_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_events
    ADD CONSTRAINT audit_events_pkey PRIMARY KEY (id);


--
-- Name: bds_public_file_rows bds_public_file_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bds_public_file_rows
    ADD CONSTRAINT bds_public_file_rows_pkey PRIMARY KEY (id);


--
-- Name: bfs_api_rows bfs_api_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bfs_api_rows
    ADD CONSTRAINT bfs_api_rows_pkey PRIMARY KEY (id);


--
-- Name: claim_reviews claim_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claim_reviews
    ADD CONSTRAINT claim_reviews_pkey PRIMARY KEY (id);


--
-- Name: data_sources data_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.data_sources
    ADD CONSTRAINT data_sources_pkey PRIMARY KEY (id);


--
-- Name: day_zero_registrations day_zero_registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.day_zero_registrations
    ADD CONSTRAINT day_zero_registrations_pkey PRIMARY KEY (id);


--
-- Name: evidence_snapshots evidence_snapshots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evidence_snapshots
    ADD CONSTRAINT evidence_snapshots_pkey PRIMARY KEY (id);


--
-- Name: export_artifacts export_artifacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.export_artifacts
    ADD CONSTRAINT export_artifacts_pkey PRIMARY KEY (id);


--
-- Name: failure_records failure_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failure_records
    ADD CONSTRAINT failure_records_pkey PRIMARY KEY (id);


--
-- Name: intake_manifests intake_manifests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intake_manifests
    ADD CONSTRAINT intake_manifests_pkey PRIMARY KEY (id);


--
-- Name: metric_definitions metric_definitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_definitions
    ADD CONSTRAINT metric_definitions_pkey PRIMARY KEY (id);


--
-- Name: metric_observations metric_observations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_observations
    ADD CONSTRAINT metric_observations_pkey PRIMARY KEY (id);


--
-- Name: metric_quality_reviews metric_quality_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_quality_reviews
    ADD CONSTRAINT metric_quality_reviews_pkey PRIMARY KEY (id);


--
-- Name: periodic_captures periodic_captures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodic_captures
    ADD CONSTRAINT periodic_captures_pkey PRIMARY KEY (id);


--
-- Name: periodic_source_checks periodic_source_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodic_source_checks
    ADD CONSTRAINT periodic_source_checks_pkey PRIMARY KEY (id);


--
-- Name: prediction_links prediction_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prediction_links
    ADD CONSTRAINT prediction_links_pkey PRIMARY KEY (id);


--
-- Name: privacy_reviews privacy_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_reviews
    ADD CONSTRAINT privacy_reviews_pkey PRIMARY KEY (id);


--
-- Name: private_artifacts private_artifacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.private_artifacts
    ADD CONSTRAINT private_artifacts_pkey PRIMARY KEY (id);


--
-- Name: quality_flags quality_flags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quality_flags
    ADD CONSTRAINT quality_flags_pkey PRIMARY KEY (id);


--
-- Name: quarterly_collection_captures quarterly_collection_captures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quarterly_collection_captures
    ADD CONSTRAINT quarterly_collection_captures_pkey PRIMARY KEY (id);


--
-- Name: quarterly_collections quarterly_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quarterly_collections
    ADD CONSTRAINT quarterly_collections_pkey PRIMARY KEY (id);


--
-- Name: quarterly_result_sets quarterly_result_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quarterly_result_sets
    ADD CONSTRAINT quarterly_result_sets_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: schema_versions schema_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_versions
    ADD CONSTRAINT schema_versions_pkey PRIMARY KEY (id);


--
-- Name: source_access_paths source_access_paths_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.source_access_paths
    ADD CONSTRAINT source_access_paths_pkey PRIMARY KEY (id);


--
-- Name: susb_public_file_rows susb_public_file_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.susb_public_file_rows
    ADD CONSTRAINT susb_public_file_rows_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_audit_events_on_entity_type_and_entity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_audit_events_on_entity_type_and_entity_id ON public.audit_events USING btree (entity_type, entity_id);


--
-- Name: index_audit_events_on_event_type_and_occurred_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_audit_events_on_event_type_and_occurred_at ON public.audit_events USING btree (event_type, occurred_at);


--
-- Name: index_bds_public_file_rows_on_capture_grain; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bds_public_file_rows_on_capture_grain ON public.bds_public_file_rows USING btree (periodic_capture_id, year, sector_code, firm_age_code, firm_size_code) WHERE (periodic_capture_id IS NOT NULL);


--
-- Name: index_bds_public_file_rows_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bds_public_file_rows_on_data_source_id ON public.bds_public_file_rows USING btree (data_source_id);


--
-- Name: index_bds_public_file_rows_on_intake_manifest_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bds_public_file_rows_on_intake_manifest_id ON public.bds_public_file_rows USING btree (intake_manifest_id);


--
-- Name: index_bds_public_file_rows_on_periodic_capture_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bds_public_file_rows_on_periodic_capture_id ON public.bds_public_file_rows USING btree (periodic_capture_id);


--
-- Name: index_bds_public_file_rows_on_row_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bds_public_file_rows_on_row_hash ON public.bds_public_file_rows USING btree (row_hash);


--
-- Name: index_bds_public_file_rows_on_schema_version_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bds_public_file_rows_on_schema_version_id ON public.bds_public_file_rows USING btree (schema_version_id);


--
-- Name: index_bds_rows_on_source_year_sector_age_size; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bds_rows_on_source_year_sector_age_size ON public.bds_public_file_rows USING btree (data_source_id, year, sector_code, firm_age_code, firm_size_code) WHERE (periodic_capture_id IS NULL);


--
-- Name: index_bds_rows_on_year_sector; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bds_rows_on_year_sector ON public.bds_public_file_rows USING btree (year, sector_code);


--
-- Name: index_bfs_api_rows_on_capture_grain; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bfs_api_rows_on_capture_grain ON public.bfs_api_rows USING btree (periodic_capture_id, period_month, data_type_code, category_code, seasonally_adj, geography_level, geography_code) WHERE (periodic_capture_id IS NOT NULL);


--
-- Name: index_bfs_api_rows_on_category_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bfs_api_rows_on_category_code ON public.bfs_api_rows USING btree (category_code);


--
-- Name: index_bfs_api_rows_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bfs_api_rows_on_data_source_id ON public.bfs_api_rows USING btree (data_source_id);


--
-- Name: index_bfs_api_rows_on_data_type_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bfs_api_rows_on_data_type_code ON public.bfs_api_rows USING btree (data_type_code);


--
-- Name: index_bfs_api_rows_on_intake_manifest_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bfs_api_rows_on_intake_manifest_id ON public.bfs_api_rows USING btree (intake_manifest_id);


--
-- Name: index_bfs_api_rows_on_period_month; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bfs_api_rows_on_period_month ON public.bfs_api_rows USING btree (period_month);


--
-- Name: index_bfs_api_rows_on_periodic_capture_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bfs_api_rows_on_periodic_capture_id ON public.bfs_api_rows USING btree (periodic_capture_id);


--
-- Name: index_bfs_api_rows_on_row_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bfs_api_rows_on_row_hash ON public.bfs_api_rows USING btree (row_hash);


--
-- Name: index_bfs_api_rows_on_schema_version_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bfs_api_rows_on_schema_version_id ON public.bfs_api_rows USING btree (schema_version_id);


--
-- Name: index_bfs_api_rows_on_seasonally_adj; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bfs_api_rows_on_seasonally_adj ON public.bfs_api_rows USING btree (seasonally_adj);


--
-- Name: index_bfs_rows_on_source_month_series_category_geo; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bfs_rows_on_source_month_series_category_geo ON public.bfs_api_rows USING btree (data_source_id, period_month, data_type_code, category_code, seasonally_adj, geography_level, geography_code) WHERE (periodic_capture_id IS NULL);


--
-- Name: index_claim_reviews_on_prediction_link_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_claim_reviews_on_prediction_link_id ON public.claim_reviews USING btree (prediction_link_id);


--
-- Name: index_data_sources_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_data_sources_on_name ON public.data_sources USING btree (name);


--
-- Name: index_data_sources_on_privacy_classification; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_data_sources_on_privacy_classification ON public.data_sources USING btree (privacy_classification);


--
-- Name: index_data_sources_on_source_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_data_sources_on_source_status ON public.data_sources USING btree (source_status);


--
-- Name: index_data_sources_on_storage_zone; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_data_sources_on_storage_zone ON public.data_sources USING btree (storage_zone);


--
-- Name: index_day_zero_registrations_on_baseline_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_day_zero_registrations_on_baseline_key ON public.day_zero_registrations USING btree (baseline_key);


--
-- Name: index_evidence_snapshots_on_version_label; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_evidence_snapshots_on_version_label ON public.evidence_snapshots USING btree (version_label);


--
-- Name: index_export_artifacts_on_evidence_snapshot_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_export_artifacts_on_evidence_snapshot_id ON public.export_artifacts USING btree (evidence_snapshot_id);


--
-- Name: index_failure_records_on_audit_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_failure_records_on_audit_event_id ON public.failure_records USING btree (audit_event_id);


--
-- Name: index_failure_records_on_failure_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_failure_records_on_failure_type ON public.failure_records USING btree (failure_type);


--
-- Name: index_failure_records_on_prediction_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_failure_records_on_prediction_id ON public.failure_records USING btree (prediction_id);


--
-- Name: index_failure_records_on_prediction_link_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_failure_records_on_prediction_link_id ON public.failure_records USING btree (prediction_link_id);


--
-- Name: index_intake_manifests_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_intake_manifests_on_data_source_id ON public.intake_manifests USING btree (data_source_id);


--
-- Name: index_metric_definitions_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_metric_definitions_on_key ON public.metric_definitions USING btree (key);


--
-- Name: index_metric_observations_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_metric_observations_on_data_source_id ON public.metric_observations USING btree (data_source_id);


--
-- Name: index_metric_observations_on_metric_definition_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_metric_observations_on_metric_definition_id ON public.metric_observations USING btree (metric_definition_id);


--
-- Name: index_metric_observations_on_period; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_metric_observations_on_period ON public.metric_observations USING btree (period);


--
-- Name: index_metric_observations_on_quarterly_result_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_metric_observations_on_quarterly_result_set_id ON public.metric_observations USING btree (quarterly_result_set_id);


--
-- Name: index_metric_observations_on_result_row; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_metric_observations_on_result_row ON public.metric_observations USING btree (quarterly_result_set_id, result_row_key) WHERE (quarterly_result_set_id IS NOT NULL);


--
-- Name: index_metric_quality_reviews_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_metric_quality_reviews_on_data_source_id ON public.metric_quality_reviews USING btree (data_source_id);


--
-- Name: index_metric_quality_reviews_on_metric_observation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_metric_quality_reviews_on_metric_observation_id ON public.metric_quality_reviews USING btree (metric_observation_id);


--
-- Name: index_metric_quality_reviews_on_observation; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_metric_quality_reviews_on_observation ON public.metric_quality_reviews USING btree (metric_observation_id);


--
-- Name: index_metric_quality_reviews_on_policy_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_metric_quality_reviews_on_policy_version ON public.metric_quality_reviews USING btree (policy_version);


--
-- Name: index_metric_quality_reviews_on_review_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_metric_quality_reviews_on_review_status ON public.metric_quality_reviews USING btree (review_status);


--
-- Name: index_metric_quality_reviews_on_reviewed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_metric_quality_reviews_on_reviewed_at ON public.metric_quality_reviews USING btree (reviewed_at);


--
-- Name: index_periodic_captures_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_periodic_captures_on_data_source_id ON public.periodic_captures USING btree (data_source_id);


--
-- Name: index_periodic_captures_on_identity; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_periodic_captures_on_identity ON public.periodic_captures USING btree (data_source_id, dataset_scope, release_identity, response_sha256, parser_version);


--
-- Name: index_periodic_source_checks_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_periodic_source_checks_on_data_source_id ON public.periodic_source_checks USING btree (data_source_id);


--
-- Name: index_periodic_source_checks_on_periodic_capture_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_periodic_source_checks_on_periodic_capture_id ON public.periodic_source_checks USING btree (periodic_capture_id);


--
-- Name: index_prediction_links_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prediction_links_on_data_source_id ON public.prediction_links USING btree (data_source_id);


--
-- Name: index_prediction_links_on_metric_observation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prediction_links_on_metric_observation_id ON public.prediction_links USING btree (metric_observation_id);


--
-- Name: index_prediction_links_on_prediction_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_prediction_links_on_prediction_id ON public.prediction_links USING btree (prediction_id);


--
-- Name: index_privacy_reviews_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_privacy_reviews_on_data_source_id ON public.privacy_reviews USING btree (data_source_id);


--
-- Name: index_privacy_reviews_on_intake_manifest_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_privacy_reviews_on_intake_manifest_id ON public.privacy_reviews USING btree (intake_manifest_id);


--
-- Name: index_private_artifacts_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_private_artifacts_on_data_source_id ON public.private_artifacts USING btree (data_source_id);


--
-- Name: index_quality_flags_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quality_flags_on_data_source_id ON public.quality_flags USING btree (data_source_id);


--
-- Name: index_quality_flags_on_metric_observation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quality_flags_on_metric_observation_id ON public.quality_flags USING btree (metric_observation_id);


--
-- Name: index_quarter_capture_on_capture; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quarter_capture_on_capture ON public.quarterly_collection_captures USING btree (periodic_capture_id);


--
-- Name: index_quarter_capture_on_collection; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quarter_capture_on_collection ON public.quarterly_collection_captures USING btree (quarterly_collection_id);


--
-- Name: index_quarter_capture_on_pair; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_quarter_capture_on_pair ON public.quarterly_collection_captures USING btree (quarterly_collection_id, periodic_capture_id);


--
-- Name: index_quarterly_collections_on_identity; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_quarterly_collections_on_identity ON public.quarterly_collections USING btree (quarter, identity_digest);


--
-- Name: index_quarterly_collections_on_quarter_and_revision; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_quarterly_collections_on_quarter_and_revision ON public.quarterly_collections USING btree (quarter, revision);


--
-- Name: index_quarterly_collections_on_quarterly_result_set_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quarterly_collections_on_quarterly_result_set_id ON public.quarterly_collections USING btree (quarterly_result_set_id);


--
-- Name: index_quarterly_result_sets_on_identity_digest; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_quarterly_result_sets_on_identity_digest ON public.quarterly_result_sets USING btree (identity_digest);


--
-- Name: index_roles_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_roles_on_name ON public.roles USING btree (name);


--
-- Name: index_schema_versions_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_schema_versions_on_data_source_id ON public.schema_versions USING btree (data_source_id);


--
-- Name: index_schema_versions_on_intake_manifest_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_schema_versions_on_intake_manifest_id ON public.schema_versions USING btree (intake_manifest_id);


--
-- Name: index_source_access_paths_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_source_access_paths_on_data_source_id ON public.source_access_paths USING btree (data_source_id);


--
-- Name: index_susb_public_file_rows_on_capture_grain; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_susb_public_file_rows_on_capture_grain ON public.susb_public_file_rows USING btree (periodic_capture_id, year, state_code, naics_code, enterprise_size_code) WHERE (periodic_capture_id IS NOT NULL);


--
-- Name: index_susb_public_file_rows_on_data_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_susb_public_file_rows_on_data_source_id ON public.susb_public_file_rows USING btree (data_source_id);


--
-- Name: index_susb_public_file_rows_on_intake_manifest_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_susb_public_file_rows_on_intake_manifest_id ON public.susb_public_file_rows USING btree (intake_manifest_id);


--
-- Name: index_susb_public_file_rows_on_periodic_capture_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_susb_public_file_rows_on_periodic_capture_id ON public.susb_public_file_rows USING btree (periodic_capture_id);


--
-- Name: index_susb_public_file_rows_on_row_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_susb_public_file_rows_on_row_hash ON public.susb_public_file_rows USING btree (row_hash);


--
-- Name: index_susb_public_file_rows_on_schema_version_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_susb_public_file_rows_on_schema_version_id ON public.susb_public_file_rows USING btree (schema_version_id);


--
-- Name: index_susb_rows_on_source_year_state_naics_size; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_susb_rows_on_source_year_state_naics_size ON public.susb_public_file_rows USING btree (data_source_id, year, state_code, naics_code, enterprise_size_code) WHERE (periodic_capture_id IS NULL);


--
-- Name: index_susb_rows_on_year_state_naics; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_susb_rows_on_year_state_naics ON public.susb_public_file_rows USING btree (year, state_code, naics_code);


--
-- Name: index_users_on_lower_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_lower_email ON public.users USING btree (lower((email)::text));


--
-- Name: index_users_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_role_id ON public.users USING btree (role_id);


--
-- Name: bds_public_file_rows periodic_baseline_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_guard BEFORE DELETE OR UPDATE ON public.bds_public_file_rows FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_member();


--
-- Name: bfs_api_rows periodic_baseline_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_guard BEFORE DELETE OR UPDATE ON public.bfs_api_rows FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_member();


--
-- Name: data_sources periodic_baseline_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_guard BEFORE DELETE OR UPDATE ON public.data_sources FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_member();


--
-- Name: intake_manifests periodic_baseline_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_guard BEFORE DELETE OR UPDATE ON public.intake_manifests FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_member();


--
-- Name: metric_definitions periodic_baseline_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_guard BEFORE DELETE OR UPDATE ON public.metric_definitions FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_member();


--
-- Name: metric_observations periodic_baseline_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_guard BEFORE DELETE OR UPDATE ON public.metric_observations FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_member();


--
-- Name: metric_quality_reviews periodic_baseline_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_guard BEFORE DELETE OR UPDATE ON public.metric_quality_reviews FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_member();


--
-- Name: schema_versions periodic_baseline_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_guard BEFORE DELETE OR UPDATE ON public.schema_versions FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_member();


--
-- Name: source_access_paths periodic_baseline_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_guard BEFORE DELETE OR UPDATE ON public.source_access_paths FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_member();


--
-- Name: susb_public_file_rows periodic_baseline_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_guard BEFORE DELETE OR UPDATE ON public.susb_public_file_rows FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_member();


--
-- Name: bds_public_file_rows periodic_baseline_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON public.bds_public_file_rows FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: bfs_api_rows periodic_baseline_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON public.bfs_api_rows FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: data_sources periodic_baseline_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON public.data_sources FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: intake_manifests periodic_baseline_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON public.intake_manifests FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: metric_definitions periodic_baseline_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON public.metric_definitions FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: metric_observations periodic_baseline_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON public.metric_observations FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: metric_quality_reviews periodic_baseline_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON public.metric_quality_reviews FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: schema_versions periodic_baseline_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON public.schema_versions FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: source_access_paths periodic_baseline_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON public.source_access_paths FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: susb_public_file_rows periodic_baseline_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_baseline_truncate BEFORE TRUNCATE ON public.susb_public_file_rows FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: periodic_captures periodic_capture_complete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_capture_complete BEFORE UPDATE ON public.periodic_captures FOR EACH ROW EXECUTE FUNCTION public.periodic_verify_capture_count();


--
-- Name: periodic_source_checks periodic_check_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_check_insert BEFORE INSERT ON public.periodic_source_checks FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_check_insert();


--
-- Name: quarterly_collections periodic_collection_complete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_collection_complete BEFORE UPDATE ON public.quarterly_collections FOR EACH ROW EXECUTE FUNCTION public.periodic_verify_collection();


--
-- Name: periodic_captures periodic_completed_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_completed_update BEFORE UPDATE ON public.periodic_captures FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_completed();


--
-- Name: quarterly_collections periodic_completed_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_completed_update BEFORE UPDATE ON public.quarterly_collections FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_completed();


--
-- Name: quarterly_result_sets periodic_completed_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_completed_update BEFORE UPDATE ON public.quarterly_result_sets FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_completed();


--
-- Name: day_zero_registrations periodic_immutable_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_immutable_update BEFORE UPDATE ON public.day_zero_registrations FOR EACH ROW EXECUTE FUNCTION public.periodic_reject_update();


--
-- Name: periodic_source_checks periodic_immutable_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_immutable_update BEFORE UPDATE ON public.periodic_source_checks FOR EACH ROW EXECUTE FUNCTION public.periodic_reject_update();


--
-- Name: quarterly_collection_captures periodic_immutable_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_immutable_update BEFORE UPDATE ON public.quarterly_collection_captures FOR EACH ROW EXECUTE FUNCTION public.periodic_reject_update();


--
-- Name: bds_public_file_rows periodic_insert_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_insert_guard BEFORE INSERT ON public.bds_public_file_rows FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_insert();


--
-- Name: bfs_api_rows periodic_insert_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_insert_guard BEFORE INSERT ON public.bfs_api_rows FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_insert();


--
-- Name: metric_observations periodic_insert_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_insert_guard BEFORE INSERT ON public.metric_observations FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_insert();


--
-- Name: susb_public_file_rows periodic_insert_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_insert_guard BEFORE INSERT ON public.susb_public_file_rows FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_insert();


--
-- Name: quarterly_collection_captures periodic_membership_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_membership_insert BEFORE INSERT ON public.quarterly_collection_captures FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_membership_insert();


--
-- Name: day_zero_registrations periodic_operational_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_delete BEFORE DELETE ON public.day_zero_registrations FOR EACH ROW EXECUTE FUNCTION public.periodic_reject_delete();


--
-- Name: periodic_captures periodic_operational_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_delete BEFORE DELETE ON public.periodic_captures FOR EACH ROW EXECUTE FUNCTION public.periodic_reject_delete();


--
-- Name: periodic_source_checks periodic_operational_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_delete BEFORE DELETE ON public.periodic_source_checks FOR EACH ROW EXECUTE FUNCTION public.periodic_reject_delete();


--
-- Name: quarterly_collection_captures periodic_operational_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_delete BEFORE DELETE ON public.quarterly_collection_captures FOR EACH ROW EXECUTE FUNCTION public.periodic_reject_delete();


--
-- Name: quarterly_collections periodic_operational_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_delete BEFORE DELETE ON public.quarterly_collections FOR EACH ROW EXECUTE FUNCTION public.periodic_reject_delete();


--
-- Name: quarterly_result_sets periodic_operational_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_delete BEFORE DELETE ON public.quarterly_result_sets FOR EACH ROW EXECUTE FUNCTION public.periodic_reject_delete();


--
-- Name: day_zero_registrations periodic_operational_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_truncate BEFORE TRUNCATE ON public.day_zero_registrations FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: periodic_captures periodic_operational_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_truncate BEFORE TRUNCATE ON public.periodic_captures FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: periodic_source_checks periodic_operational_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_truncate BEFORE TRUNCATE ON public.periodic_source_checks FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: quarterly_collection_captures periodic_operational_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_truncate BEFORE TRUNCATE ON public.quarterly_collection_captures FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: quarterly_collections periodic_operational_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_truncate BEFORE TRUNCATE ON public.quarterly_collections FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: quarterly_result_sets periodic_operational_truncate; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_operational_truncate BEFORE TRUNCATE ON public.quarterly_result_sets FOR EACH STATEMENT EXECUTE FUNCTION public.periodic_guard_truncate();


--
-- Name: quarterly_result_sets periodic_result_complete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_result_complete BEFORE UPDATE ON public.quarterly_result_sets FOR EACH ROW EXECUTE FUNCTION public.periodic_verify_result_count();


--
-- Name: metric_quality_reviews periodic_review_insert_guard; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER periodic_review_insert_guard BEFORE INSERT ON public.metric_quality_reviews FOR EACH ROW EXECUTE FUNCTION public.periodic_guard_review_insert();


--
-- Name: source_access_paths fk_rails_087fc77344; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.source_access_paths
    ADD CONSTRAINT fk_rails_087fc77344 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: periodic_source_checks fk_rails_0a552d77bb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodic_source_checks
    ADD CONSTRAINT fk_rails_0a552d77bb FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: bfs_api_rows fk_rails_0c3cb5b131; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bfs_api_rows
    ADD CONSTRAINT fk_rails_0c3cb5b131 FOREIGN KEY (intake_manifest_id) REFERENCES public.intake_manifests(id);


--
-- Name: intake_manifests fk_rails_127e60d285; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.intake_manifests
    ADD CONSTRAINT fk_rails_127e60d285 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: claim_reviews fk_rails_1635ad3e18; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.claim_reviews
    ADD CONSTRAINT fk_rails_1635ad3e18 FOREIGN KEY (prediction_link_id) REFERENCES public.prediction_links(id);


--
-- Name: bfs_api_rows fk_rails_27d9ba0250; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bfs_api_rows
    ADD CONSTRAINT fk_rails_27d9ba0250 FOREIGN KEY (schema_version_id) REFERENCES public.schema_versions(id);


--
-- Name: metric_observations fk_rails_2e69e0f579; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_observations
    ADD CONSTRAINT fk_rails_2e69e0f579 FOREIGN KEY (quarterly_result_set_id) REFERENCES public.quarterly_result_sets(id);


--
-- Name: metric_observations fk_rails_2fc0b41c8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_observations
    ADD CONSTRAINT fk_rails_2fc0b41c8d FOREIGN KEY (metric_definition_id) REFERENCES public.metric_definitions(id);


--
-- Name: metric_observations fk_rails_3383fe537a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_observations
    ADD CONSTRAINT fk_rails_3383fe537a FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: metric_quality_reviews fk_rails_34309ab5c2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_quality_reviews
    ADD CONSTRAINT fk_rails_34309ab5c2 FOREIGN KEY (metric_observation_id) REFERENCES public.metric_observations(id);


--
-- Name: prediction_links fk_rails_378f313e57; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prediction_links
    ADD CONSTRAINT fk_rails_378f313e57 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: susb_public_file_rows fk_rails_39a3bece20; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.susb_public_file_rows
    ADD CONSTRAINT fk_rails_39a3bece20 FOREIGN KEY (intake_manifest_id) REFERENCES public.intake_manifests(id);


--
-- Name: bfs_api_rows fk_rails_465317094f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bfs_api_rows
    ADD CONSTRAINT fk_rails_465317094f FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: failure_records fk_rails_4962882095; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failure_records
    ADD CONSTRAINT fk_rails_4962882095 FOREIGN KEY (audit_event_id) REFERENCES public.audit_events(id);


--
-- Name: bds_public_file_rows fk_rails_4989c0a6f9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bds_public_file_rows
    ADD CONSTRAINT fk_rails_4989c0a6f9 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: bds_public_file_rows fk_rails_49a2729604; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bds_public_file_rows
    ADD CONSTRAINT fk_rails_49a2729604 FOREIGN KEY (schema_version_id) REFERENCES public.schema_versions(id);


--
-- Name: quarterly_collection_captures fk_rails_56c0cf1216; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quarterly_collection_captures
    ADD CONSTRAINT fk_rails_56c0cf1216 FOREIGN KEY (periodic_capture_id) REFERENCES public.periodic_captures(id);


--
-- Name: schema_versions fk_rails_58d7a60258; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_versions
    ADD CONSTRAINT fk_rails_58d7a60258 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: susb_public_file_rows fk_rails_5dbae68964; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.susb_public_file_rows
    ADD CONSTRAINT fk_rails_5dbae68964 FOREIGN KEY (periodic_capture_id) REFERENCES public.periodic_captures(id);


--
-- Name: users fk_rails_642f17018b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_642f17018b FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: quarterly_collections fk_rails_649afd8e6a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quarterly_collections
    ADD CONSTRAINT fk_rails_649afd8e6a FOREIGN KEY (quarterly_result_set_id) REFERENCES public.quarterly_result_sets(id);


--
-- Name: periodic_captures fk_rails_68cfa951c5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodic_captures
    ADD CONSTRAINT fk_rails_68cfa951c5 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: privacy_reviews fk_rails_7006566c98; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_reviews
    ADD CONSTRAINT fk_rails_7006566c98 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: susb_public_file_rows fk_rails_70db78b1a4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.susb_public_file_rows
    ADD CONSTRAINT fk_rails_70db78b1a4 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: bds_public_file_rows fk_rails_75dc1e1cd1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bds_public_file_rows
    ADD CONSTRAINT fk_rails_75dc1e1cd1 FOREIGN KEY (periodic_capture_id) REFERENCES public.periodic_captures(id);


--
-- Name: quality_flags fk_rails_7e3ce34687; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quality_flags
    ADD CONSTRAINT fk_rails_7e3ce34687 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: privacy_reviews fk_rails_844c4a9134; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_reviews
    ADD CONSTRAINT fk_rails_844c4a9134 FOREIGN KEY (intake_manifest_id) REFERENCES public.intake_manifests(id);


--
-- Name: failure_records fk_rails_9143bad418; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failure_records
    ADD CONSTRAINT fk_rails_9143bad418 FOREIGN KEY (prediction_link_id) REFERENCES public.prediction_links(id);


--
-- Name: bds_public_file_rows fk_rails_994888a166; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bds_public_file_rows
    ADD CONSTRAINT fk_rails_994888a166 FOREIGN KEY (intake_manifest_id) REFERENCES public.intake_manifests(id);


--
-- Name: metric_quality_reviews fk_rails_9ce51ba244; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.metric_quality_reviews
    ADD CONSTRAINT fk_rails_9ce51ba244 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: schema_versions fk_rails_9dea6d6f7f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_versions
    ADD CONSTRAINT fk_rails_9dea6d6f7f FOREIGN KEY (intake_manifest_id) REFERENCES public.intake_manifests(id);


--
-- Name: quarterly_collection_captures fk_rails_9e24148c1b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quarterly_collection_captures
    ADD CONSTRAINT fk_rails_9e24148c1b FOREIGN KEY (quarterly_collection_id) REFERENCES public.quarterly_collections(id);


--
-- Name: prediction_links fk_rails_b1669b4793; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prediction_links
    ADD CONSTRAINT fk_rails_b1669b4793 FOREIGN KEY (metric_observation_id) REFERENCES public.metric_observations(id);


--
-- Name: private_artifacts fk_rails_be3d85cbc4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.private_artifacts
    ADD CONSTRAINT fk_rails_be3d85cbc4 FOREIGN KEY (data_source_id) REFERENCES public.data_sources(id);


--
-- Name: quality_flags fk_rails_c162908c72; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quality_flags
    ADD CONSTRAINT fk_rails_c162908c72 FOREIGN KEY (metric_observation_id) REFERENCES public.metric_observations(id);


--
-- Name: bfs_api_rows fk_rails_d311c69dea; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bfs_api_rows
    ADD CONSTRAINT fk_rails_d311c69dea FOREIGN KEY (periodic_capture_id) REFERENCES public.periodic_captures(id);


--
-- Name: periodic_source_checks fk_rails_d4ffe5fc1b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.periodic_source_checks
    ADD CONSTRAINT fk_rails_d4ffe5fc1b FOREIGN KEY (periodic_capture_id) REFERENCES public.periodic_captures(id);


--
-- Name: susb_public_file_rows fk_rails_e6c639b7da; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.susb_public_file_rows
    ADD CONSTRAINT fk_rails_e6c639b7da FOREIGN KEY (schema_version_id) REFERENCES public.schema_versions(id);


--
-- Name: export_artifacts fk_rails_e9599c50cf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.export_artifacts
    ADD CONSTRAINT fk_rails_e9599c50cf FOREIGN KEY (evidence_snapshot_id) REFERENCES public.evidence_snapshots(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20260918091000'),
('20260918090000'),
('20260614043000'),
('20260613133000'),
('20260612233000'),
('20260612230000'),
('20260612110000');
