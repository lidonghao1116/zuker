module SmsConfirmableActions

  extend ActiveSupport::Concern

  module ClassMethods
  end

  def phone_verify
    has_verified? or return
    flash[:success] = "You already have finished verification."
    redirect_to user_path(@user)
  end

  def verify_pin
    case @user.verify(params[:verify][:pin])# && user.pin.error_times < 3
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

  def has_verified?
    return current_user.verified
  end

  def reverify_if_phone_changed?
    if @old_phone_number != @user.phone_number
      @user.update_attribute(:verified, false)
      @user.resend_pin
    end
  end

end