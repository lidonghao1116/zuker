module ApplicationHelper
  def comment ; end

  def notice_message
    alert_types = { notice: :success, alert: :danger }
 
    close_button_options = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
    close_button = content_tag(:button, "×", close_button_options)
 
    alerts = flash.map do |type, message|
      alert_content = close_button + message
 
      alert_type = alert_types[type.to_sym] || type
      alert_class = "alert alert-#{alert_type} alert-dismissable"
 
      content_tag(:div, alert_content, class: alert_class)
    end

    alerts.join("\n").html_safe
  end

  def render_option_category(value, option, model_data)
    key = model_data.constantize.public_send("#{option}_categories").key(value)
    I18n.t("#{option}_categories.#{key}") if key
  end
  
  # def glyph(name)
  #   content_tag :span, '', class:"glyphicon glyphicon-#{name}", aria:{ hidden:"true" }
  # end
end
