require "csv"
require "digest"
require "fileutils"
require "net/http"
require "set"
require "tempfile"
require "uri"

module PublicSources
  module Susb
    class FetchAndValidatePublicFile
      class ValidationError < StandardError; end

      Result = Data.define(
        :data_source,
        :source_access_path,
        :intake_manifest,
        :schema_version,
        :local_path,
        :fetched_this_run,
        :sha256,
        :byte_size,
        :row_count_including_header,
        :row_count_excluding_header,
        :bad_width_rows,
        :blank_lines,
        :duplicate_key_count,
        :noise_flag_counts,
        :manifest_reconciled
      )

      def self.call!(actor:, year: nil, force_fetch: false, fetcher: nil, local_path: nil, manifest_path: nil)
        new(
          actor: actor,
          year: year,
          force_fetch: force_fetch,
          fetcher: fetcher,
          local_path: local_path,
          manifest_path: manifest_path
        ).call!
      end

      def initialize(actor:, year:, force_fetch:, fetcher:, local_path:, manifest_path:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @ingestion_policy = @policy.fetch(:public_ingestion_v1)
        @susb_policy = @ingestion_policy.fetch(:susb_us_state_annual)
        @year = year || @susb_policy.fetch(:default_year)
        @force_fetch = force_fetch
        @fetcher = fetcher || method(:download_public_file)
        @local_path = Pathname(local_path || repo_root.join(format(@susb_policy.fetch(:local_raw_path_template), year: @year)))
        @manifest_path = Pathname(manifest_path || repo_root.join("data/manifests/susb_#{@year}_manifest.csv"))
      end

      def call!
        scaffold = find_or_create_scaffold
        fetched_this_run = fetch_raw_file_if_needed
        validation = validate_raw_file!
        manifest_reconciled = reconcile_manifest!(validation)

        update_registry!(scaffold, validation, fetched_this_run, manifest_reconciled)

        Result.new(
          data_source: scaffold.fetch(:data_source),
          source_access_path: scaffold.fetch(:source_access_path),
          intake_manifest: scaffold.fetch(:intake_manifest),
          schema_version: scaffold.fetch(:schema_version),
          local_path: local_path.to_s,
          fetched_this_run: fetched_this_run,
          sha256: validation.fetch(:sha256),
          byte_size: validation.fetch(:byte_size),
          row_count_including_header: validation.fetch(:row_count_including_header),
          row_count_excluding_header: validation.fetch(:row_count_excluding_header),
          bad_width_rows: validation.fetch(:bad_width_rows),
          blank_lines: validation.fetch(:blank_lines),
          duplicate_key_count: validation.fetch(:duplicate_key_count),
          noise_flag_counts: validation.fetch(:noise_flag_counts),
          manifest_reconciled: manifest_reconciled
        )
      end

      private

      attr_reader :actor, :ingestion_policy, :susb_policy, :year, :force_fetch,
                  :fetcher, :local_path, :manifest_path

      def find_or_create_scaffold
        source = DataSource.find_by(name: source_name, source_kind: susb_policy.fetch(:source_kind))
        return existing_scaffold(source) if source

        PublicSources::Susb::PublicFileScaffold.call!(actor: actor, year: year)
      end

      def existing_scaffold(source)
        {
          data_source: source,
          source_access_path: source.source_access_paths.find_by!(access_type: "official_public_file"),
          intake_manifest: source.intake_manifests.find_by!(name: manifest_name),
          schema_version: source.schema_versions.find_by!(version: susb_policy.fetch(:schema_version))
        }
      end

      def source_name
        "#{susb_policy.fetch(:source_name)} #{year}"
      end

      def manifest_name
        format(susb_policy.fetch(:manifest_name_template), year: year)
      end

      def fetch_raw_file_if_needed
        return false if local_path.exist? && !force_fetch

        FileUtils.mkdir_p(local_path.dirname)
        Audit::Recorder.record_system!(
          actor: actor,
          event_type: "collection_started",
          entity_type: "PublicSourceFile",
          entity_id: "susb_#{year}",
          change_summary: "SUSB public file fetch started for #{year}",
          reason_code: "susb_public_file_fetch"
        )

        fetcher.call(source_url, local_path)

        Audit::Recorder.record_system!(
          actor: actor,
          event_type: "collection_completed",
          entity_type: "PublicSourceFile",
          entity_id: "susb_#{year}",
          change_summary: "SUSB public file fetch completed for #{year}",
          reason_code: "susb_public_file_fetch"
        )

        true
      end

      def download_public_file(url, destination)
        uri = URI(url)
        Tempfile.create([ "susb-#{year}", ".txt" ], destination.dirname) do |tempfile|
          tempfile.binmode
          Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
            request = Net::HTTP::Get.new(uri)
            http.request(request) do |response|
              raise ValidationError, "SUSB fetch failed with HTTP #{response.code}" unless response.is_a?(Net::HTTPSuccess)

              response.read_body { |chunk| tempfile.write(chunk) }
            end
          end
          tempfile.close
          FileUtils.mv(tempfile.path, destination)
        end
      end

      def validate_raw_file!
        raise ValidationError, "SUSB raw file missing at #{local_path}" unless local_path.exist?

        sha256 = Digest::SHA256.file(local_path).hexdigest
        byte_size = local_path.size
        header = nil
        row_count_excluding_header = 0
        bad_width_rows = 0
        blank_lines = 0
        keys = Set.new
        duplicate_key_count = 0
        noise_flag_counts = noise_flag_columns.index_with { {} }

        File.open(local_path, "r:ISO-8859-1:UTF-8") do |file|
          CSV.new(file, headers: true).each.with_index(2) do |row, line_number|
            header ||= row.headers
            if row.fields.all?(&:blank?)
              blank_lines += 1
              next
            end

            row_count_excluding_header += 1
            bad_width_rows += 1 unless row.fields.length == expected_header.length
            key = row_grain.map { |field| row.fetch(field) }.join("\u0000")
            duplicate_key_count += 1 unless keys.add?(key)

            noise_flag_columns.each do |field|
              value = row.fetch(field)
              noise_flag_counts.fetch(field)[value] = noise_flag_counts.fetch(field).fetch(value, 0) + 1
            end

            invalid_flags = noise_flag_columns.filter_map do |field|
              value = row.fetch(field)
              "#{field}=#{value} at line #{line_number}" unless allowed_noise_flags.include?(value)
            end
            raise ValidationError, "unexpected SUSB noise flags: #{invalid_flags.join(', ')}" if invalid_flags.any?
          end
        end

        header ||= CSV.open(local_path, "r:ISO-8859-1:UTF-8", &:first)
        validate_header!(header)
        validate_zero_structure_issues!(bad_width_rows, blank_lines, duplicate_key_count)

        {
          sha256: sha256,
          byte_size: byte_size,
          row_count_including_header: row_count_excluding_header + 1,
          row_count_excluding_header: row_count_excluding_header,
          bad_width_rows: bad_width_rows,
          blank_lines: blank_lines,
          duplicate_key_count: duplicate_key_count,
          noise_flag_counts: noise_flag_counts
        }
      end

      def validate_header!(header)
        raise ValidationError, "SUSB header mismatch: #{header.inspect}" unless header == expected_header

        missing = required_columns - header
        raise ValidationError, "SUSB required columns missing: #{missing.join(', ')}" if missing.any?
      end

      def validate_zero_structure_issues!(bad_width_rows, blank_lines, duplicate_key_count)
        failures = []
        failures << "bad_width_rows=#{bad_width_rows}" if bad_width_rows.positive?
        failures << "blank_lines=#{blank_lines}" if blank_lines.positive?
        failures << "duplicate_key_count=#{duplicate_key_count}" if duplicate_key_count.positive?
        return if failures.empty?

        raise ValidationError, "SUSB structural validation failed: #{failures.join(', ')}"
      end

      def reconcile_manifest!(validation)
        return false unless manifest_path.exist?

        manifest_row = CSV.read(manifest_path, headers: true).find do |row|
          row.fetch("dataset").include?("SUSB #{year}")
        end
        raise ValidationError, "SUSB manifest row missing for #{year}" unless manifest_row

        expected = {
          "content_length" => validation.fetch(:byte_size).to_s,
          "local_path" => local_path.relative_path_from(repo_root).to_s,
          "sha256" => validation.fetch(:sha256),
          "row_count" => validation.fetch(:row_count_including_header).to_s,
          "field_list" => expected_header.join(";")
        }
        mismatches = expected.filter_map do |field, value|
          "#{field}: expected #{value}, found #{manifest_row[field]}" unless manifest_row[field] == value
        end
        raise ValidationError, "SUSB manifest mismatch: #{mismatches.join('; ')}" if mismatches.any?

        true
      end

      def update_registry!(scaffold, validation, fetched_this_run, manifest_reconciled)
        DataSource.transaction do
          source = scaffold.fetch(:data_source)
          access_path = scaffold.fetch(:source_access_path)
          manifest = scaffold.fetch(:intake_manifest)

          source.update!(
            source_status: "raw_file_validated",
            metadata: source.metadata.merge(validation_metadata(validation, fetched_this_run, manifest_reconciled))
          )
          access_path.update!(
            status: "fetched_and_validated",
            last_checked_at: Time.current,
            metadata: access_path.metadata.merge(validation_metadata(validation, fetched_this_run, manifest_reconciled))
          )
          manifest.update!(
            manifest_status: "raw_file_validated",
            metadata: manifest.metadata.merge(validation_metadata(validation, fetched_this_run, manifest_reconciled))
          )

          Audit::Recorder.record!(
            actor: actor,
            event_type: "validation_completed",
            entity: manifest,
            change_summary: "Validated SUSB #{year} public-file structure without metric computation",
            reason_code: "susb_public_file_validation",
            storage_zone: source.storage_zone,
            privacy_classification: source.privacy_classification,
            source_id: source.id
          )
        end
      end

      def validation_metadata(validation, fetched_this_run, manifest_reconciled)
        validation.merge(
          "local_path" => local_path.relative_path_from(repo_root).to_s,
          "source_url" => source_url,
          "fetched_this_run" => fetched_this_run,
          "manifest_reconciled" => manifest_reconciled,
          "metrics_authorized" => false,
          "analysis_authorized" => false,
          "claim_status_effect" => ingestion_policy.fetch(:claim_status_effect_default)
        ).deep_stringify_keys
      end

      def expected_header
        susb_policy.fetch(:expected_header)
      end

      def required_columns
        susb_policy.fetch(:required_columns)
      end

      def row_grain
        susb_policy.fetch(:row_grain)
      end

      def noise_flag_columns
        %w[EMPLFL_N PAYRFL_N RCPTFL_N]
      end

      def allowed_noise_flags
        susb_policy.fetch(:allowed_noise_flags)
      end

      def repo_root
        Rails.root.parent
      end

      def source_url
        susb_policy.fetch(:source_url).sub("/2022/", "/#{year}/").sub("_2022.", "_#{year}.")
      end
    end
  end
end
