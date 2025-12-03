class BsFormBuilder < ActionView::Helpers::FormBuilder
  delegate :safe_join, to: :@template

  def bs_text_field_wrapper(field, method, options = {})
    if options[:wrapper_div_classes]
      wrapper_div_classes = options[:wrapper_div_classes]
    else
      wrapper_div_classes = "form-floating mb-3"
    end
    options[:placeholder] = method.to_s.humanize if options[:placeholder].nil?
    options[:class] = "form-control" if options[:class].nil?
    errors_markup =  if @object.errors[method].any?
      "<div class=\"invalid-feedback d-block\">#{@object.errors[method].to_sentence}</div>".html_safe
    end

    safe_join [
      "<div class=\"#{wrapper_div_classes}\">".html_safe,
      send(field, method, options),
      label(method),
      errors_markup,
      "</div>".html_safe
    ].compact
  end

  def bs_text_field(method, options = {})
    bs_text_field_wrapper("text_field", method, options)
  end

  def bs_password_field(method, options = {})
    bs_text_field_wrapper("password_field", method, options)
  end
end
