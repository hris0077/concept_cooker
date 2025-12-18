class EventSubscriber
  def emit(event)
    Rails.logger.info(event)
    return unless crud_event?(event[:name])

    case event[:name]
    when ->(e) { crud_event?(e) }
      AuditLogJob.set(queue: :audit).perform_later(
        event_name: event[:name],
        loggable: event[:payload][:loggable],
        request_id: event[:payload][:request],
        metadata: event[:payload][:changes],
        created_by_id: 5
      )
    end
  end

  def crud_event?(event_name)
    event_name.ends_with?(".update", ".create", ".delete")
  end
end

Rails.event.subscribe(EventSubscriber.new) { |event| event[:name].starts_with?("users.") }
