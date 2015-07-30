module SmsConfirmable
  extend ActiveSupport::Concern
  
  include Webhookable

  included do 
    has_one :pin, as: :sms_confirmable
  end

  VERIFY_TIME_LIMIT = 300

  def random_4_digits
    # 不滿四位就左邊補0
    rand(0000..9999).to_s.rjust(4, "0")
  end
  
  def generate_pin
    self.create_pin content: random_4_digits
  end

  def twilio_client
    Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
  end

  def send_pin
    number = self.phone_number
    #message = twilio_client.account.messages.create from: '+18085183344', to: international_number('TW', number), body: "歡迎來到租客Zuker，您的驗證碼為#{self.pin.content}, 請上www.zuker.com.tw完成您的註冊。"
    #message.status
  end

  def international_number(country, phone_number)
    return "+886#{phone_number[1..9]}" if country == 'TW'
  end

  def verify(entered_pin)
    if Time.current - self.pin.created_at > VERIFY_TIME_LIMIT
      resend_pin
    elsif self.pin.content == entered_pin# && self.pin.error_times < 5
      return update_attribute(:verified, true)
    else
      return false
    end
  end

  def resend_pin
    self.pin.destroy
    self.create_pin content: random_4_digits
    self.send_pin
    return 'resend'
  end

end