ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  if html_tag =~ /<label/
    # For labels, just return as-is or add text-danger class
    html_tag.gsub(/class="([^"]*)"/, 'class="\1 text-danger"').html_safe
  elsif html_tag =~ /<input|textarea|select/
    # For form fields, add is-invalid class
    if html_tag.include?('class="')
      html_tag.gsub(/class="([^"]*)"/, 'class="\1 is-invalid"').html_safe
    else
      html_tag.gsub(/(<input|<textarea|<select)/, '\1 class="is-invalid"').html_safe
    end
  else
    html_tag.html_safe
  end
end
