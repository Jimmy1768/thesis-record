require "net/http"

module Evidence
  class SourceReleaseCheckJob < ApplicationJob
    queue_as :maintenance

    def perform(network_enabled: true, http_client: Net::HTTP)
      result = Operations::V0SourceFreshnessDryRun.call(
        network_enabled: network_enabled,
        http_client: http_client
      )

      Audit::Recorder.record_system!(
        actor: self.class.name,
        event_type: "source_release_check_completed",
        entity_type: "SchedulerCheckpoint",
        entity_id: "source_release_check",
        change_summary: change_summary(result),
        reason_code: "scheduled_source_release_check"
      )
    end

    private

    def change_summary(result)
      [
        "Source-release check completed",
        "passed=#{result.passed}",
        "network_enabled=#{result.network_enabled}",
        "sources=#{source_summary(result)}",
        "blockers=#{result.blockers.empty? ? '(none)' : result.blockers.join('|')}",
        "warnings=#{result.warnings.empty? ? '(none)' : result.warnings.join('|')}",
        "effects=no_row_writes,no_metric_writes,no_reviews,no_claims,no_exports,no_publication"
      ].join("; ")
    end

    def source_summary(result)
      result.sources.map do |source|
        checked = source.endpoints.count(&:network_checked)
        configured = source.endpoints.count(&:configured)
        statuses = source.endpoints.map { |endpoint| endpoint.status || "not_checked" }.join("/")
        "#{source.source_kind}:#{checked}/#{configured}:#{statuses}"
      end.join(",")
    end
  end
end
