# app/jobs/audit_log_job.rb
class AuditLogJob < ApplicationJob
  queue_as :audit
  # Accept only JSON-serializable data
  def perform(event_name:, loggable:, request_id:, metadata:, created_by_id:)
    # Reify loggable (optional: skip if you only need IDs)
    # loggable = loggable_type.constantize.find_by(id: loggable.id)
    record = loggable&.class.find_by(id: loggable&.id)
    puts "loggable"
    Rails.logger.info(record)
    return unless record

    params  = {
      event_name: event_name,
      created_by_id: created_by_id,
      request_id: request_id,
      metadata: metadata,
      loggable: record
    }

    AuditLog.create!(params)
  rescue ActiveRecord::RecordNotFound
    # Loggable was deleted — still log if needed
    AuditLog.create!(params)
  end
end
