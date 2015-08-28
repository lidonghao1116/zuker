module SmsConfirmableActions

  extend ActiveSupport::Concern

  included do    
    before_action :has_phone_number?, only:[:phone_verify, :verify_pin, :resend_pin]
  end

  class_methods do
  end

  def phone_verify
    Not_verified_yet?
    if current_user.pin_invalid?
      flash[:info] = "Hey, we have send you a new pin. Please check your phone."
      redirect_to phone_verify_user_path(current_user)
    end
  end

  def verify_pin
    if current_user.verify(params[:verify][:pin])
      flash[:success] = "Success!"
      redirect_to user_path
    else
      flash[:warning] = "Sorry, that wasn't the right pin."
      redirect_to phone_verify_user_path(current_user)
    end
  end

  def resend_pin
    case current_user.resend_pin
    when false
      flash[:warning] = "please input phone number."
      redirect_to edit_user_path(current_user)
    else
      flash[:info] = "Hey, we have send you a new pin. Please check your phone."
      redirect_to phone_verify_user_path(current_user)
    end
  end

  private

    def Not_verified_yet?
      if current_user.verified  
        flash[:success] = "You already have finished verification."
        redirect_to user_path(current_user)
      end
    end

    def has_phone_number?
      unless current_user.phone_number
        redirect_to edit_user_path(current_user)
      end
    end

end