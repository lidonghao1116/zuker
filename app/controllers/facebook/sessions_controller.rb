class Facebook::SessionsController < ApplicationController
  def new
    redirect_to '/auth/facebook'
  end

  def create
    auth = request.env["omniauth.auth"]
    if current_user # if login then connect with it
      if existing_fb_user = User.where(:provider => auth['provider'], :uid => auth['uid'].to_s).first
        # 1. have connected
        if existing_fb_user.sign_with_zuker
          session[:user_id] = existing_fb_user.id
          flash[:info] = "Your facebook had been connected before!"
          redirect_to user_path(existing_fb_user)
        # 2. haven't connected
        else
          existing_fb_user.destroy
          signin(@user) if @user.update_with_omniauth(auth)
        end
      else # never use fb before
        signin(@user) if @user.update_with_omniauth(auth)
      end
    else
      @user = User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
      signin(@user)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

    def auth_hash
      request.env['omniauth.auth']
    end

    def signin(user)
      session[:user_id] = user.id
      flash[:success] = "login with facebook successfully!"
      redirect_to user_path(user)      
    end
end