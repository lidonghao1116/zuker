class NotificationsController < ApplicationController
  include Webhookable

  skip_before_action :verify_authenticity_token

  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.account.messages.create from: '+18085183344', to: '+886920085183', body: 'Learning to send SMS you are. Plz go to http://www.zuker.com.tw to finish your registration.', status_callback: request.base_url + '/notifications/status'
    render plain: message.status
  end

  def status
    render_twiml Twilio::TwiML::Response.new
  end

end