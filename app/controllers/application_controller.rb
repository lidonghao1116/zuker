class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_locale

  def current_user
    User.find_by_id(session[:user_id])
  end
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
