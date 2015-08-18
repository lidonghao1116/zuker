class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy, :basic, :amenity, :description, :photo, :date_status]
  layout "house_panel", only: [:basic, :amenity, :description, :photo, :date_status]
  before_action :no_validate, only: [:basic, :amenity, :description, :photo, :date_status]
  before_action :action_based_validation, only: [:basic, :amenity, :description, :photo, :date_status]

  # GET /houses
  # GET /houses.json
  def index
    @houses = House.all
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
  end

  # GET /houses/new
  def new
    @house = House.new
    session[:validate] = "basic"
  end

  # GET /houses/1/edit
  def edit
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(house_params)

    respond_to do |format|
      if @house.save
        format.html {
          redirect_to basic_house_path(@house)
          flash[:success] = t('flash.messages.success')
        }
        format.json { render :json => @house }
      else
        format.html { render :new }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    @house.validate = session[:validate]
    respond_to do |format|
      if @house.update(house_params)
        if params[:image]
          params[:image].each do |picture|
            @house.attachments.create(:image => picture)
            # Don't forget to mention :avatar(field name)
          end
          flash[:success] = t('flash.messages.upload_success')
        end
        #flash[:success] = t('flash.messages.success')
        #redirect_to house_path(@house)
        format.html {
          redirect_to :back
          #flash[:success] = t('flash.messages.success')
        }
        format.json { head :ok }
      else
        format.json { render :json => { :error => @house.errors.full_messages }, :status => 422 }
      end
    end
  end

  def basic
  end

  def amenity
  end

  def description
  end

  def photo
  end

  def date_status
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
    respond_to do |format|
      format.html { redirect_to houses_url, notice: 'House was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def no_validate
      session[:validate] = nil
    end

    def action_based_validation
      session[:validate] = action_name
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      params.require(:house).permit(:title, :description, :price, :image, :house_type, :gender, :foreigner, :english_help, :photo_help, :city, :district, :address, :zipcode, :hide_address, :personal_parking_lot, :available_date, :reservable_date, :area, :building_floor, :at_floor, :special_floor, :direction, :bedroom, :shared_space, :bathroom, :balcony, :school_id, :min_lease, :security_fee, safety: [], amenity: [], furniture: [], extra_fee: [], public_facility: [], rule: [])
    end
end