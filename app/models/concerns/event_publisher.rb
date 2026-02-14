module EventPublisher
  extend ActiveSupport::Concern

  included do
    after_commit :publish_action_event, on: [ :create, :update ]

    before_destroy :publish_destroy_event
  end

  def publish_action_event
    action = audit_action
    return if action == :update && saved_changes.blank?
    Rails.event.notify(
      audit_action,
      payload.merge(changes: saved_changes)
    )
  end

  def publish_destroy_event
    # Store all needed data BEFORE record is destroyed
    Rails.event.notify(
      "#{self.class.model_name.plural}.destroy",
      payload.merge(
        changes: {},
        metadata: {
          deleted_at: Time.current,
          loggable_id: self.id, loggable_type: self.class.name
        }
      )
    )
  end

  def payload
    {
      request: Time.now.to_i,
      attributes: self.attributes.symbolize_keys.slice(:id, :name),
      loggable_type: self.class.name,
      loggable_id: self.id,
      metadata: { loggable_id: self.id, loggable_type: self.class.name }
    }
  end

  def audit_action
    "#{self.class.model_name.plural}.#{event_name}"
  end

  def event_name
    action =
      if transaction_include_any_action?([ :create ])
        :create
      elsif transaction_include_any_action?([ :destroy ])
        :destroy
      else
        :update
      end
    action
  end
end
