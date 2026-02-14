# app/jobs/audit_log_job.rb
class AuditLogJob < ApplicationJob
  queue_as :audit
  def perform(event_name:, loggable:, request_id:, metadata:, created_by_id:)
    params  = {
      event_name: event_name,
      created_by_id: created_by_id,
      request_id: request_id,
      metadata: metadata,
      loggable_type: loggable[:audit_type],
      loggable_id: loggable[:audit_id]
    }

    AuditLog.create!(params)
  rescue ActiveRecord::RecordNotFound
    AuditLog.create!(params)
  end
end
