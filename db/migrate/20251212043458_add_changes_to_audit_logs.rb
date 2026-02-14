class AddChangesToAuditLogs < ActiveRecord::Migration[8.1]
  def change
    add_column :audit_logs, :changes, :json
    rename_column :audit_logs, :user_id, :created_by_id
  end
end
