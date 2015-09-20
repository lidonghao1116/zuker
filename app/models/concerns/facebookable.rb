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
        user.password_digest = "facebook-authorized-account"

        user.provider = auth['provider']
        user.uid = auth['uid']
        if auth['info']
          Rails.logger.debug(auth)
          user.first_name = auth['info']['first_name']
          user.last_name = auth['info']['last_name']
          user.email = auth['info']['email']
          user.image = auth['info']['image']
          #user.fb_url = auth['info']['urls']['Facebook']
          user.location = auth['info']['location']
        end
        if auth['extra']['raw_info']
          user.school_name << auth['extra']['raw_info'].try(:education).try(:last).try(:school).try(:name)
          user.start_school_year = auth['extra']['raw_info'].try(:education).try(:last).try(:year).try(:name) || 'Not found.'
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
        user.email = auth['info']['email']
        user.image = auth['info']['image']
        user.fb_url = auth['info']['urls']['Facebook']
        user.location = auth['info']['location']
      end
      if auth['extra']['raw_info']
        user.school_name << auth['extra']['raw_info'].try(:education).try(:last).try(:school).try(:name)
        user.start_school_year = auth['extra']['raw_info'].try(:education).try(:last).try(:year).try(:name) || 'Not found.'
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
      image: user.image,
      fb_url: user.fb_url,
      location: user.location
    })

    # self.houses.try(:each) do |house|
    #   house.owner_id = self.id
    # end

  end
  
end