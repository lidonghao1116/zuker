class SessionsController < ApplicationController
  def new ; end

  def create
    respond_to do |format|
      if @user = password_is_right
        session[:user_id] = @user.id
        format.js
      end
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end