require "yaml"

module Evidence
  class AnnualSnapshotCandidate
    Result = Data.define(
      :as_of,
      :current_period,
      :snapshot_period,
      :first_snapshot_period,
      :snapshot_index,
      :candidate_status,
      :forecast_count,
      :source_row_counts,
      :protected_counts,
      :warnings,
      :effects
    )

    THESIS_ROOT = Rails.root.join("..", "theses", "operator-node-economics").expand_path
    V0_TIMELINE_PATH = THESIS_ROOT.join("publication", "v0_timeline.yml")
    V0_FORECAST_SET_PATH = THESIS_ROOT.join("publication", "v0_forecast_set.yml")

    SOURCE_ROW_MODELS = Evidence::QuarterlyIndicatorCheckpointCandidate::SOURCE_ROW_MODELS
    PROTECTED_MODELS = Evidence::QuarterlyIndicatorCheckpointCandidate::PROTECTED_MODELS
    EFFECTS = Evidence::QuarterlyIndicatorCheckpointCandidate::EFFECTS

    def self.call(as_of: Time.current)
      new(as_of: as_of).call
    end

    def initialize(as_of:)
      @as_of = as_of
    end

    def call
      timeline = load_yaml(V0_TIMELINE_PATH)
      forecast_set = load_yaml(V0_FORECAST_SET_PATH)
      current_period = period_for(as_of)
      snapshot_period = previous_period(current_period)
      first_snapshot_period = timeline.dig(:annual_snapshot, :first_snapshot_period)
      frequency = timeline.dig(:annual_snapshot, :frequency_quarters).presence || 4
      snapshot_index = snapshot_index_for(first_snapshot_period, snapshot_period, frequency)

      Result.new(
        as_of: as_of,
        current_period: current_period,
        snapshot_period: snapshot_period,
        first_snapshot_period: first_snapshot_period,
        snapshot_index: snapshot_index,
        candidate_status: candidate_status(snapshot_index),
        forecast_count: forecast_set.fetch(:forecasts, []).count,
        source_row_counts: count_models(SOURCE_ROW_MODELS),
        protected_counts: count_models(PROTECTED_MODELS),
        warnings: warnings(first_snapshot_period, forecast_set, snapshot_period, frequency),
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

    def previous_period(period)
      ordinal_to_period(quarter_ordinal(period) - 1)
    end

    def snapshot_index_for(first_snapshot_period, snapshot_period, frequency)
      return nil if first_snapshot_period.blank?

      offset = quarter_ordinal(snapshot_period) - quarter_ordinal(first_snapshot_period)
      return nil if offset.negative? || (offset % frequency) != 0

      (offset / frequency) + 1
    end

    def candidate_status(snapshot_index)
      return "not_annual_snapshot_period" if snapshot_index.blank?

      "annual_snapshot_candidate"
    end

    def quarter_ordinal(period)
      match = period.to_s.match(/\A(?<year>\d{4})-Q(?<quarter>[1-4])\z/)
      raise ArgumentError, "invalid quarter period: #{period.inspect}" unless match

      (match[:year].to_i * 4) + match[:quarter].to_i
    end

    def ordinal_to_period(ordinal)
      year, zero_based_quarter = (ordinal - 1).divmod(4)

      "#{year}-Q#{zero_based_quarter + 1}"
    end

    def count_models(models)
      models.transform_values(&:count)
    end

    def warnings(first_snapshot_period, forecast_set, snapshot_period, frequency)
      [].tap do |warnings|
        warnings << "first_snapshot_period_missing" if first_snapshot_period.blank?
        warnings << "forecast_set_missing" if forecast_set.blank?
        warnings << "not_annual_snapshot_period" if first_snapshot_period.present? &&
          snapshot_index_for(first_snapshot_period, snapshot_period, frequency).blank?
        warnings << "forecast_items_unapproved" if forecast_set.fetch(:forecasts, []).any? do |forecast|
          forecast.fetch(:v0_status, nil) == "candidate_unapproved"
        end
      end
    end
  end
end
