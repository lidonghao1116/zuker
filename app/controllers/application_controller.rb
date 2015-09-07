class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_locale
  before_action :set_search
  before_action :clean_invalid_signin_session
  
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def password_is_right
      User.find_by_phone_number(params[:user][:phone_number]).try(:authenticate, params[:user][:password])
    end

    def log_in(user)
      session[:user_id] = user.id
    end

    def log_out
      session[:user_id] = nil
    end

    # def correct_user_sign_in?
    #   # 登入紀錄與訪問頁面id相同 && 目前登入者有效
    #   unless session[:user_id].to_s == params[:id] && current_user
    #     flash[:danger] = "Sorry, you need to sign in or register."
    #     redirect_to signup_path and return
    #   end
    # end

    def has_verify_phone?
      unless current_user.verified
        flash[:danger] = "Sorry, you need to verify phone number first."
        redirect_to phone_verify_user_path(current_user) and return
      end
    end

    # def has_sign_with_zuker? # 從EDIT更新過資料成為ZUKER會員
    #   unless current_user.sign_with_zuker
    #     flash[:info] = "Finish your profile to become a real Zuker."
    #     #redirect_to edit_user_path(current_user) and return
    #   end
    # end
   
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def set_search
      @q = House.ransack(params[:q])
      @criteria = :title_or_description_cont
    end

    def clean_invalid_signin_session
      session[:user_id] = nil unless current_user
    end

    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore

      flash[:warning] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
      if policy_name == 'room_policy' && exception.query == 'new?'
        redirect_to(basic_house_path(params[:house_id]) || root_path)
      else
        redirect_to(request.referrer || root_path)
      end
    end

end
