module SmsConfirmable
  extend ActiveSupport::Concern
  
  include Webhookable

  included do 
    has_one :pin, as: :sms_confirmable
  end
  
  def generate_pin
    # 不滿四位就左邊補0
    r = rand(0000..9999).to_s.rjust(4, "0")
    self.create_pin content: r
  end

  def twilio_client
    Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
  end

  def send_pin
    number = self.phone_number
    message = twilio_client.account.messages.create from: '+18085183344', to: international_number('TW', number), body: "Plz input #{self.pin.content} to http://www.zuker.com.tw to finish your registration."
    message.status
  end

  def international_number(country, phone_number)
    return "+886#{phone_number[1..9]}" if country == 'TW'
  end

  def verify(entered_pin)
    #update(verified: true) if 
    self.pin.content == entered_pin
  end

end