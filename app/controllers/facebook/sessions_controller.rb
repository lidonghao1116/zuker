class Facebook::SessionsController < ApplicationController
  def new
    redirect_to '/auth/facebook'
  end

  def create
    auth = request.env["omniauth.auth"]
    if current_user.sign_with_zuker && current_user.provider != 'facebook' # PURE zuker w/o FB
      if fb_used(auth)
        connect_with_this_fb(fb_used)
      else # never use fb before
        signin(@user) if @user.update_with_omniauth(auth)
      end
    else # !!!!!!!!!!!!!!!!!!!!
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

    def fb_used(auth)
      User.where(:provider => auth['provider'], :uid => auth['uid'].to_s).first
    end

    def connect_with_this_fb(fb_user)
      # 1. have connected
      if fb_user.sign_with_zuker
        session[:user_id] = fb_user.id
        flash[:info] = "Your facebook had been connected before!"
        redirect_to user_path(fb_user)
      # 2. haven't connected
      else
        fb_user.destroy
        signin(@user) if @user.update_with_omniauth(auth)
      end      
    end


end