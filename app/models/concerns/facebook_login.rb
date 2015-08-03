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
        user.email = auth['info']['image']
        #if auth['info']
           #user.name = auth['info']['name'] || ""
        #end
      end
    end
  end

  def update_existing_zuker_with_omniauth(auth)
    self.update({
      :provider => auth['provider'],
      :uid => auth['uid'],
      :sign_with_zuker => true,
      #if auth['info']
         :first_name => auth['info']['first_name'],
         :last_name => auth['info']['last_name'],
         :email => auth['info']['image']
      #end
    })
  end

  def merge_existing_fb_user_to(user)
    self.update({
      :provider => user.provider,
      :uid => user.uid
    }) 
  end
  
end