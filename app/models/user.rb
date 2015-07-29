class User < ActiveRecord::Base
  include ActiveModel::Dirty
  has_secure_password
  # Password must be present on creation
  # Password length should be less than or equal to 72 characters
  # Confirmation of password (using a password_confirmation attribute)
  validates_length_of :password, :within => 6..20, :allow_blank => true
  # allow_blank => 
  # when true
  #   編輯資料時不需輸入密碼
  # when false
  #   編輯時必須輸入密碼&密碼確認

  validates :name, presence: true
  validates :phone_number, presence: true, format: { with: /\A[0][9][0-9]{2}[0-9]{6}\z/ }, uniqueness: true
  #validates :email, uniqueness: true, :allow_blank => true

  include SmsConfirmable
  
  
end
