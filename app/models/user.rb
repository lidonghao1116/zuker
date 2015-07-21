class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :password, length: { in: 6..20 }, confirmation: true
end
