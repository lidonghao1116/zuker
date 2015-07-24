class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: { in: 6..20 }, confirmation: true
  
  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /[0][9][0-9]{2}[0-9]{6}/ }
  #validates :email, uniqueness: true, :allow_blank => true

  include SmsConfirmable
  
end
