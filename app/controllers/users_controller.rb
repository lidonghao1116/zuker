class UsersController < ApplicationController
  before_action :correct_user_sign_in?, only: [:show, :edit, :update, :destroy, :phone_verify]

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
        #@user.send_pin
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
    redirect_to user_path(current_user)
  end

  def verify_pin
    current_user.pin.update(error_times: error_times + 1) unless current_user.verify(params[:pin])
    if current_user.verified
      flash[:success] = "Success!"
      redirect_to user_path
    else
      flash[:warning] = "Sorry, that wasn't the right pin."
      render :phone_verify
    end
  end

  def verify_again
    current_user.resend_pin if current_user.pin.error_times > 2
    redirect_to phone_verify_user_path(current_user)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    current_user.destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def correct_user_sign_in?
      unless session[:user_id].to_s == params[:id]
        flash[:danger] = "Sorry, you need to sign in or register."
        redirect_to signup_users_path and return
      end
    end

    def has_verified?
      return current_user.verified
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :phone_number, :email, :expected_graduation_date, :verified)
    end

    def exist_user_params
      params.require(:user).permit(:name, :phone_number, :email, :expected_graduation_date, :verified)
    end
end
