class ChangeChangesToMetadata < ActiveRecord::Migration[8.1]
  def change
    rename_column :audit_logs, :changes, :metadata
  end
end
