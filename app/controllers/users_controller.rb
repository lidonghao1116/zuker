class UsersController < ApplicationController
  before_action :correct_user_sign_in?, only: [:show, :edit, :update, :destroy, :phone_verify, :verify_pin, :resend_pin, :change_phone_number]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  ####  After Register  ####

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        @user.generate_pin
        @user.send_pin
        format.html { redirect_to phone_verify_user_path(@user), notice: 'Please check your verification code.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  ####  After login  ####

  def phone_verify
    has_verified? or return
    flash[:success] = "You already have finished verification."
    redirect_to user_path(@user)
  end

  def verify_pin
    case @user.verify(params[:verify][:pin])# && user.pin.error_times < 3
    when false
      flash[:warning] = "Sorry, that wasn't the right pin."
      redirect_to phone_verify_user_path(@user)
    when true
      flash[:success] = "Success!"
      redirect_to user_path
    when 'resend'
      flash[:info] = "Hey, we have send you a new pin. Please check your phone."
      redirect_to phone_verify_user_path(@user)
    end
  end

  def resend_pin
    @user.resend_pin
    flash[:info] = "Hey, we have send you a new pin. Please check your phone."
    redirect_to phone_verify_user_path(@user)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @old_phone_number = @user.phone_number
    respond_to do |format|
      if @user.update(user_params)
        if reverify_if_phone_changed?
          flash[:info] = 'Please check your verification code.'
          redirect_to phone_verify_user_path(@user) and return 
        else
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        end
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def correct_user_sign_in?
      unless session[:user_id].to_s == params[:id] && current_user
        flash[:danger] = "Sorry, you need to sign in or register."
        redirect_to signup_users_path and return
      end
    end

    def has_verified?
      return current_user.verified
    end

    def reverify_if_phone_changed?
      if @old_phone_number != @user.phone_number
        @user.update_attribute(:verified, false)
        @user.resend_pin
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :phone_number, :email, :school_id, :start_school_year, :verified)
    end
end
