module EventPublisher
  extend ActiveSupport::Concern

  included do
    after_action :publish_action_event
  end

  def publish_action_event
    Rails.event.notify(
      event_name,
      request: request.request_id,
      changes: @record.present? ? @record.saved_changes : nil,
      loggable: @record
    )
  end

  def event_name
    "#{controller_name}.#{action_name}"
  end

  def find_record
    instance_variable_get("@#{controller_name.singularize}")
  end
end
