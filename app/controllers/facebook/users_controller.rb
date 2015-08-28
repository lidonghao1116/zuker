class Facebook::UsersController < ApplicationController

  def connect_with_zuker
    if @user = password_is_right
      if @user.merge_existing_fb_user_to(User.find_by_id(session[:user_id]))
        User.find_by_id(session[:user_id]).destroy
        session[:user_id] = @user.id
        flash[:success] = 'Connect with zuker successfully!'
        redirect_to user_path(@user)
      end
    else
      flash[:danger] = 'wrong username or password'
      redirect_to :back
    end
  end

  # def connect_with_fb
  #   if fb_user = User.where(:provider => auth['provider'], :uid => auth['uid'].to_s).first
  #     connect_with_this_fb(fb_user, auth)
  #   else # never use fb before
  #     signin(@user) if @user.update_existing_zuker_with_omniauth(auth)
  #   end
  # end

  # def fb_used(auth)
  #   fb_user = User.where(:provider => auth['provider'], :uid => auth['uid'].to_s).first
  # end

  # def connect_with_this_fb(fb_user, auth)
  #   # 1. have connected
  #   if fb_user.sign_with_zuker
  #     session[:user_id] = fb_user.id
  #     flash[:info] = "Your facebook had been connected before!"
  #     redirect_to user_path(fb_user)
  #   # 2. haven't connected
  #   else
  #     fb_user.destroy
  #     signin(@user) if @user.update_with_omniauth(auth)
  #   end      
  # end

end