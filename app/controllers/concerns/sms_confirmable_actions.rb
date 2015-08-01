module SmsConfirmableActions

  extend ActiveSupport::Concern

  included do    
    before_action :has_phone_number?, only:[:phone_verify, :verify_pin, :resend_pin]
  end

  class_methods do
  end

  def phone_verify
    Not_verified_yet?
  end

  def verify_pin
    case @user.verify(params[:verify][:pin])
    when false
      flash[:warning] = "Sorry, that wasn't the right pin."
      redirect_to phone_verify_user_path(@user)
    when true
      flash[:success] = "Success!"
      redirect_to user_path
    when 'resend'
      flash[:info] = "Hey, we have send you a new pin. Please check your phone."
      redirect_to phone_verify_user_path(@user)
    end
  end

  def resend_pin
    case @user.resend_pin
    when false
      flash[:warning] = "please input phone number."
      redirect_to edit_user_path(@user)
    else
      flash[:info] = "Hey, we have send you a new pin. Please check your phone."
      redirect_to phone_verify_user_path(@user)
    end
  end

  private

    def Not_verified_yet?
      if current_user.verified  
        flash[:success] = "You already have finished verification."
        redirect_to user_path(@user)
      end
    end

    def has_phone_number?
      unless @user.phone_number
        redirect_to edit_user_path(@user)
      end
    end

end