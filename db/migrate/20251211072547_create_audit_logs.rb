class CreateAuditLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :audit_logs do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.references :loggable, polymorphic: true, null: false
      t.string :request_id

      t.timestamps
    end
  end
end
