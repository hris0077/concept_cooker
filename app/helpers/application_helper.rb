module ApplicationHelper
  def format_time(time)
    time.strftime("%m/%d/%Y %I:%M %p")
  end

  def render_flash_stream
    turbo_stream.update('flash', partial: 'shared/flash')
  end

  def flash_class(type)
    case type
    when 'notice' then 'success'
    when 'alert' then 'danger'
    end
  end
end
