class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: { in: 6..20 }, confirmation: true
  
  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true
  #validates :email, uniqueness: true, :allow_blank => true
end
