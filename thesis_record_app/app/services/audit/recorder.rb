module Audit
  class Recorder
    def self.record!(actor:, event_type:, entity:, change_summary:, reason_code:,
                     storage_zone:, privacy_classification:,
                     claim_status_effect: "unchanged", export_allowed: false,
                     previous_state_hash: nil, new_state_hash: nil,
                     review_required: false, review_id: nil,
                     source_id: nil, snapshot_id: nil, request_id: nil,
                     job_id: nil, ip_or_host: nil)
      actor_type, actor_id = actor_parts(actor)

      AuditEvent.create!(
        occurred_at: Time.current,
        actor_type: actor_type,
        actor_id: actor_id,
        event_type: event_type,
        entity_type: entity.class.name,
        entity_id: entity.id.to_s,
        source_id: source_id || infer_source_id(entity),
        snapshot_id: snapshot_id,
        request_id: request_id,
        job_id: job_id,
        previous_state_hash: previous_state_hash,
        new_state_hash: new_state_hash,
        change_summary: change_summary,
        reason_code: reason_code,
        review_required: review_required,
        review_id: review_id,
        storage_zone: storage_zone,
        privacy_classification: privacy_classification,
        claim_status_effect: claim_status_effect,
        export_allowed: export_allowed,
        ip_or_host: ip_or_host
      )
    end

    def self.record_system!(actor:, event_type:, entity_type:, entity_id:, change_summary:, reason_code:,
                            storage_zone: "production_postgresql", privacy_classification: "internal",
                            claim_status_effect: "unchanged", export_allowed: false,
                            request_id: nil, job_id: nil, ip_or_host: nil)
      actor_type, actor_id = actor_parts(actor)

      AuditEvent.create!(
        occurred_at: Time.current,
        actor_type: actor_type,
        actor_id: actor_id,
        event_type: event_type,
        entity_type: entity_type,
        entity_id: entity_id,
        request_id: request_id,
        job_id: job_id,
        change_summary: change_summary,
        reason_code: reason_code,
        review_required: false,
        storage_zone: storage_zone,
        privacy_classification: privacy_classification,
        claim_status_effect: claim_status_effect,
        export_allowed: export_allowed,
        ip_or_host: ip_or_host
      )
    end

    def self.actor_parts(actor)
      case actor
      when User
        [ "User", actor.id.to_s ]
      when String, Symbol
        [ actor.to_s, nil ]
      else
        [ actor.class.name, actor.try(:id)&.to_s ]
      end
    end
    private_class_method :actor_parts

    def self.infer_source_id(entity)
      entity.respond_to?(:data_source_id) ? entity.data_source_id : nil
    end
    private_class_method :infer_source_id
  end
end
