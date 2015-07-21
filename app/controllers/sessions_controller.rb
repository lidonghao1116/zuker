class SessionsController < ApplicationController
  def new ; end
  def create
    @user = User.find_by_phone_number(params[:user][:phone_number]).try(:authenticate, params[:user][:password])

    if @user
      session[:user_id] = @user.id
      flash[:success] = "Welcome back. #{@user.name}"
    else
      flash[:danger] = "Wrong phone number or password."
    end

    redirect_to :back
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end