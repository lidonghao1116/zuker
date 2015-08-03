class Facebook::SessionsController < ApplicationController
  def new
    redirect_to '/auth/facebook'
  end

  def create
    auth = request.env["omniauth.auth"]
    if current_user#.try(:sign_with_zuker) && current_user.provider != 'facebook' # PURE zuker w/o FB
      redirect_to connect_with_fb_user_path(current_user)
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


end