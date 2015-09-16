class UsersController < ApplicationController
  #before_action :correct_user_sign_in?, except: [:new, :create, :show, :new_comment]
  #before_action :has_sign_with_zuker?, only: [:edit, :update]
  layout 'panel', only: [ :new, :create, :edit, :update ]

  include SmsConfirmableActions
  include CommentableActions

  # GET /users/new
  def new
    @user = User.new
    authorize @user
  end

  ####  After Register  ####

  def create
    @user = User.new(user_params)
    authorize @user
    respond_to do |format|
      if @user.save
        log_in(@user)
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

  ####  After sign in  ####

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @comments = @user.comments.recent.page params[:page]
    @new_comment = @user.comments.new
  end

  def profile
    current_user.reload
    @comments = current_user.comments.page params[:page]
    @my_houses = current_user.houses
    @new_comment = current_user.comments.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update    
    @user = current_user# unless current_user.admin?
    authorize @user
    @old_phone_number = @user.phone_number
    respond_to do |format|
      if @user.update(user_params)
        reverify_if_phone_changed and return
        format.html { redirect_to profile_path, notice: 'User was successfully updated.' }
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
    @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def reverify_if_phone_changed
      if @old_phone_number != current_user.phone_number
        if current_user.update_attribute(:verified, false) && current_user.resend_pin
          flash[:info] = 'Please check your verification code.'
          redirect_to phone_verify_user_path(current_user)
        else
          flash[:info] = 'Please check your phone number.'
          redirect_to edit_user_path(current_user)
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :phone_number, :email, :school_id, :start_school_year, :verified, :provider, :uid, :sign_with_zuker)
    end
end
