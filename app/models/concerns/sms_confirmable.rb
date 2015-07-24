module SmsConfirmable
  extend ActiveSupport::Concern

  included do 
    has_one :pin, as: :sms_confirmable
  end
  
  def generate_pin
    # 不滿四位就左邊補0
    r = rand(0000..9999).to_s.rjust(4, "0")
    self.create_pin content: r
  end

  def send_pin
    
  end

end