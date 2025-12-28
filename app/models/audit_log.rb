# == Schema Information
#
# Table name: audit_logs
#
#  id            :integer          not null, primary key
#  created_by_id :integer          not null
#  loggable_type :string           not null
#  loggable_id   :integer          not null
#  request_id    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  event_name    :string
#  metadata      :json
#
# Indexes
#
#  index_audit_logs_on_created_by_id  (created_by_id)
#  index_audit_logs_on_loggable       (loggable_type,loggable_id)
#

class AuditLog < ApplicationRecord
  belongs_to :created_by, class_name: "User"
  # belongs_to :loggable, polymorphic: true

  serialize :metadata, coder: EnhancedMetadata

  broadcasts_to ->(audit_log) { "audit_logs" }, inserts_by: :prepend
end
