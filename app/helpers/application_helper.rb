module ApplicationHelper
  def comment ; end

  def notice_message
    alert_types = { danger: :error, notice: :warning }

    close_button = content_tag(:span, '', class: 'close icon')

    alerts = flash.map do |type, message|
      alert_content = close_button + content_tag(:div, message, class: 'header')
 
      alert_type = alert_types[type.to_sym] || type
      alert_class = "ui #{alert_type} message"
 
      content_tag(:div, alert_content, class: alert_class)
    end

    alerts.join("\n").html_safe
  end
  
  def glyph(name)
    content_tag :span, '', class: "glyphicon glyphicon-#{name}", aria:{ hidden:"true" }
  end  

  def warning(text)
    content_tag :div, class: "alert alert-dismissible alert-warning" do    
      button_tag 'x', class: 'close', type: 'button', data: { dismiss: 'alert' }
      content_tag :h4, 'Sorry!'
      content_tag :p, text
    end
  end

  def horizontal_divider(text)
    content_tag(:div, text, class: "ui horizontal divider")
  end
end
