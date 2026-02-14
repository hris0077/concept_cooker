class BsFormBuilder < ActionView::Helpers::FormBuilder
  delegate :safe_join, :content_tag, to: :@template

  def text_field(method, options = {})
    options[:class] = "form-control #{options[:class]}".strip
    options[:placeholder] ||= method.to_s.humanize

    content_tag(:div, class: "form-floating mb-3") do
      safe_join([
        super(method, options),
        label(method),
        field_errors(method)
      ])
    end
  end

  alias_method :password_field, :text_field


  def field_errors(method)
    return unless @object.errors[method].any?
    content_tag(:div, @object.errors[method].to_sentence, class: "invalid-feedback d-block")
  end
end
