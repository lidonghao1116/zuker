class NotificationsController < ApplicationController
  include Webhookable

  skip_before_action :verify_authenticity_token

  def twilio_client
    Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
  end

  def notify
    number = current_user.phone_number
    message = twilio_client.account.messages.create from: '+18085183344', to: international_number('TW', number), body: 'Learning to send SMS you are. Plz go to http://www.zuker.com.tw to finish your registration.', status_callback: request.base_url + '/notifications/status'
    render plain: message.status
  end

  def international_number(country, phone_number)
    return "+886#{phone_number[1..9]}" if country == 'TW'
  end

  def status
    render_twiml Twilio::TwiML::Response.new
  end

end