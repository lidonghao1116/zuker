module FacebookLogin

  #before_action :has_sign_with_zuker?, only: [:edit, :phone_verify]

  extend ActiveSupport::Concern

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  class_methods do
    def create_with_omniauth(auth)
      create! do |user|
        user.sign_with_zuker = false # default is nil
        user.password = user.password_confirmation = ""
        user.password_digest = "facebook-authorized account"
        user.provider = auth['provider']
        user.uid = auth['uid']
        #if auth['info']
           #user.name = auth['info']['name'] || ""
        #end
      end
    end
  end

  def update_with_omniauth(auth)
    self.update({
      :provider => auth['provider'],
      :uid => auth['uid']
      #if auth['info']
         #user.name = auth['info']['name'] || ""
      #end
    })
  end
  
end