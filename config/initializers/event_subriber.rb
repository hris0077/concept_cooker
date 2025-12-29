class EventSubscriber
  def emit(event)
    Rails.logger.info(event)
    return unless crud_event?(event[:name])

    case event[:name]
    when ->(e) { crud_event?(e) }
      AuditLogJob.set(queue: :audit).perform_later(
        event_name: event[:name],
        loggable: { audit_type: event[:payload][:loggable_type], audit_id: event[:payload][:loggable_id] },
        request_id: event[:payload][:request],
        metadata: { changes: event[:payload][:changes], attributes: event[:payload][:attributes] },
        created_by_id: User.first.id
      )
    end
  end

  def crud_event?(event_name)
    event_name.ends_with?(".update", ".create", ".destroy")
  end
end

Rails.event.subscribe(EventSubscriber.new) { |event| event[:name].starts_with?("users.") }
