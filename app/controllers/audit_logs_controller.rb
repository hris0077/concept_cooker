class AuditLogsController < ApplicationController
  def index
    @pagy_logs, @audit_logs = pagy(AuditLog.all)
  end
end
