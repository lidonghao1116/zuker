class Facebook::SessionsController < ApplicationController
  def new
    redirect_to '/auth/facebook'
  end

  def create
    auth = request.env["omniauth.auth"]
    fb_user = User.where(:provider => auth['provider'],
                       :uid => auth['uid'].to_s).first
    zuker = fb_user.try(:phone_number) && fb_user.try(:sign_with_zuker)
    has_signin = session[:user_id]

    if !zuker && has_signin
      current_user.update_with_omniauth(auth)
      fb_user.destroy if fb_user
      signin(current_user)
    elsif !zuker && !has_signin && !fb_user
      signin(User.create_with_omniauth(auth))
    else
      signin(fb_user)
    end

  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

    def signin(user)
      if session[:user_id].nil?
        flash[:success] = "login with facebook successfully!"
      else
        flash[:success] = "Your facebook has been connected before!"
      end
      log_in(user)
      redirect_to :back
    end


end