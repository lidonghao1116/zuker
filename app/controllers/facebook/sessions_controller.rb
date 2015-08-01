class Facebook::SessionsController < ApplicationController
  def new
    redirect_to '/auth/facebook'
  end

  def create
    auth = request.env["omniauth.auth"]
    if current_user # if login then connect with it
      existing_fb_user = User.where(:provider => auth['provider'], :uid => auth['uid'].to_s).first
      if existing_fb_user.nil? # if never use FB to login
        if @user.update_with_omniauth(auth)
          session[:user_id] = @user.id
          flash[:success] = "connect with facebook successfully!"
          redirect_to user_path(@user)
        end
      elsif existing_fb_user.sign_with_zuker # if FB had been connected, switch to that user.
        @user = existing_fb_user
        session[:user_id] = @user.id
        flash[:info] = "Your facebook had been connected before!"
        redirect_to user_path(@user)
      else # FB had been used but not connected yet
        ##### SHOULD move data of existing_fb_user to @user ####
        existing_fb_user.destroy
        if @user.update_with_omniauth(auth)
          session[:user_id] = @user.id
          flash[:success] = "connect with facebook successfully!"
          redirect_to user_path(@user)
        end
      end
    else
      @user = User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
      session[:user_id] = @user.id
      flash[:success] = "login with facebook successfully!"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end