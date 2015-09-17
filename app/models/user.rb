class User < ActiveRecord::Base

  include SmsConfirmable
  include Commentable
  include Facebookable

  has_many :houses, inverse_of: :owner, foreign_key: :user_id
  belongs_to :school, inverse_of: :users
  
  with_options if: :sign_with_zuker? do |z|
    z.has_secure_password
    # Password must be present on creation
    # Password length should be less than or equal to 72 characters
    # Confirmation of password (using a password_confirmation attribute)
    z.validates_length_of :password, :within => 6..20, :allow_blank => true
    # allow_blank => 
    # when true
    #   編輯資料時不需輸入密碼
    # when false
    #   編輯時必須輸入密碼&密碼確認

    z.validates :first_name, presence: true
    z.validates :last_name, presence: true
    z.validates :phone_number, presence: true, format: { with: /\A[0][9][0-9]{2}[0-9]{6}\z/ }, uniqueness: true
    validates :email, uniqueness: true, :allow_blank => true, format: { with: /.+@.+\..+/i }
    # ex: fasff@4f6w4f6.aa
  end

  def full_name
    "#{first_name} #{last_name}"
  end
  
end
