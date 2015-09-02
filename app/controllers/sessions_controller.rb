class SessionsController < ApplicationController
  def new ; end

  def create
    if @user = password_is_right
      session[:user_id] = @user.id
      flash[:success] = "Welcome back. #{@user.first_name}"
      redirect_to profile_path
    else
      flash[:danger] = "Wrong phone number or password."
      redirect_to signin_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end