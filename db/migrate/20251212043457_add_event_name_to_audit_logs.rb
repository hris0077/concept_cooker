class AddEventNameToAuditLogs < ActiveRecord::Migration[8.1]
  def change
    add_column :audit_logs, :event_name, :string
  end
end
