require "yaml"

module Evidence
  class QuarterlyIndicatorCheckpointCandidate
    Result = Data.define(
      :as_of,
      :current_period,
      :first_measurement_period,
      :measurement_index,
      :candidate_status,
      :checkpoint_ref,
      :checkpoint_target_periods,
      :forecast_count,
      :source_row_counts,
      :protected_counts,
      :warnings,
      :effects
    )

    THESIS_ROOT = Rails.root.join("..", "theses", "operator-node-economics").expand_path
    V0_TIMELINE_PATH = THESIS_ROOT.join("publication", "v0_timeline.yml")
    V0_FORECAST_SET_PATH = THESIS_ROOT.join("publication", "v0_forecast_set.yml")

    SOURCE_ROW_MODELS = {
      susb_public_file_rows: SusbPublicFileRow,
      bfs_api_rows: BfsApiRow,
      bds_public_file_rows: BdsPublicFileRow
    }.freeze

    PROTECTED_MODELS = {
      metric_definitions: MetricDefinition,
      metric_observations: MetricObservation,
      metric_quality_reviews: MetricQualityReview,
      prediction_links: PredictionLink,
      claim_reviews: ClaimReview,
      export_artifacts: ExportArtifact,
      evidence_snapshots: EvidenceSnapshot,
      failure_records: FailureRecord
    }.freeze

    EFFECTS = %w[
      no_row_writes
      no_metric_writes
      no_reviews
      no_prediction_links
      no_claims
      no_exports
      no_publication
      no_thesis_verdict
    ].freeze

    def self.call(as_of: Time.current)
      new(as_of: as_of).call
    end

    def initialize(as_of:)
      @as_of = as_of
    end

    def call
      timeline = load_yaml(V0_TIMELINE_PATH)
      forecast_set = load_yaml(V0_FORECAST_SET_PATH)
      first_period = timeline.dig(:forecast_clock, :first_measurement_period)
      current_period = period_for(as_of)
      target_periods = checkpoint_target_periods(timeline)
      measurement_index = measurement_index_for(first_period, current_period)

      Result.new(
        as_of: as_of,
        current_period: current_period,
        first_measurement_period: first_period,
        measurement_index: measurement_index,
        candidate_status: candidate_status(measurement_index),
        checkpoint_ref: checkpoint_ref_for(current_period, target_periods),
        checkpoint_target_periods: target_periods,
        forecast_count: forecast_set.fetch(:forecasts, []).count,
        source_row_counts: count_models(SOURCE_ROW_MODELS),
        protected_counts: count_models(PROTECTED_MODELS),
        warnings: warnings(first_period, forecast_set),
        effects: EFFECTS
      )
    end

    private

    attr_reader :as_of

    def load_yaml(path)
      return {} unless path.exist?

      YAML.safe_load_file(path).deep_symbolize_keys
    end

    def period_for(time)
      year = time.to_date.year
      quarter = ((time.to_date.month - 1) / 3) + 1

      "#{year}-Q#{quarter}"
    end

    def checkpoint_target_periods(timeline)
      timeline.fetch(:checkpoints, {}).transform_values do |checkpoint|
        checkpoint.fetch(:target_period, nil)
      end.compact
    end

    def measurement_index_for(first_period, current_period)
      return nil if first_period.blank?

      index = quarter_ordinal(current_period) - quarter_ordinal(first_period) + 1
      index.positive? ? index : nil
    end

    def quarter_ordinal(period)
      match = period.to_s.match(/\A(?<year>\d{4})-Q(?<quarter>[1-4])\z/)
      raise ArgumentError, "invalid quarter period: #{period.inspect}" unless match

      (match[:year].to_i * 4) + match[:quarter].to_i
    end

    def candidate_status(measurement_index)
      return "pre_first_measurement_period" if measurement_index.blank?

      "quarterly_checkpoint_candidate"
    end

    def checkpoint_ref_for(current_period, target_periods)
      target_periods.find { |_checkpoint, target_period| target_period == current_period }&.first&.to_s
    end

    def count_models(models)
      models.transform_values(&:count)
    end

    def warnings(first_period, forecast_set)
      [].tap do |warnings|
        warnings << "first_measurement_period_missing" if first_period.blank?
        warnings << "forecast_set_missing" if forecast_set.blank?
        warnings << "forecast_items_unapproved" if forecast_set.fetch(:forecasts, []).any? do |forecast|
          forecast.fetch(:v0_status, nil) == "candidate_unapproved"
        end
      end
    end
  end
end
