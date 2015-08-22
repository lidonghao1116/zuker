module Facebookable

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
        if auth['info']
          user.first_name = auth['info']['first_name']
          user.last_name = auth['info']['last_name']
          user.email = auth['info']['email']
          user.image = auth['info']['image']
          user.fb_url = auth['info']['urls']['Facebook']
          user.location = auth['extra']['raw_info']['education'] #auth['info']['location']          
        end
      end
    end
  end

  def update_with_omniauth(auth)
    self.tap do |user|
      user.sign_with_zuker = true
      user.provider = auth['provider'] || ""
      user.uid = auth['uid']
      if auth['info']
        user.first_name = auth['info']['first_name']
        user.last_name = auth['info']['last_name']
        user.email = auth #['info']['email']
        user.image = auth['info']['image']
        user.fb_url = auth['info']['urls']['Facebook']
        user.location = auth['info']['location']
      end
    end
    self.save
  end

  def merge_existing_fb_user_to(user)
    self.update({
      provider: user.provider,
      uid: user.uid,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      name: user.name,
      fb_url: user.fb_url,
      location: user.location
    }) 
  end
  
end