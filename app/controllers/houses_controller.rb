class HousesController < ApplicationController
  layout "house_panel", only: [:update]
  
  before_action :set_house, except: [:index, :new, :create]
  before_action :set_user, except: [:show, :index]

  include CommentableActions
  include HouseProfileActions

  # GET /houses
  # GET /houses.json
  def index
    @houses = current_user.houses.all.page params[:page]
    authorize @houses
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
    @comments = @house.comments.page params[:page]
    render layout: "panel"
  end

  # GET /houses/new
  def new
    @house = current_user.houses.new
    authorize @house
    session[:validate] = "basic"
    render layout: 'panel'
  end

  # GET /houses/1/edit
  def edit
    authorize @house
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = current_user.houses.new(house_params)
    authorize @house

    respond_to do |format|
      if @house.save
        format.html {
          redirect_to basic_house_path(@house), layout: 'panel'
          #flash[:success] = t('flash.messages.success')
        }
        format.json { render :json => @house }
      else
        format.html { render :new, layout: 'panel' }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    authorize @house
    @house.validate = session[:validate]
    respond_to do |format|
      if @house.update(house_params)
        if params[:image]
          params[:image].each { |picture| @house.attachments.create(:image => picture) }
          flash[:success] = t('flash.messages.upload_success')
        end
        format.html { redirect_to :back }
      else
        format.html { render "houses/profiles/#{session[:validate]}" }
        format.js { render :json => { :error => @house.errors.full_messages }, :status => 422 }
      end
    end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    def set_user
      redirect_to root_path, notice: "Please sign in or register first." unless current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      params.require(:house).permit(:title, :description, :price, :image, :house_type, :gender, :foreigner, :english_help, :photo_help, :city, :district, :address, :zipcode, :hide_address, :personal_parking_lot, :available_date, :reservable_date, :area, :building_floor, :at_floor, :special_floor, :direction, :bedroom, :shared_space, :bathroom, :balcony, :school_id, :min_lease, :security_fee, safety: [], amenity: [], furniture: [], extra_fee: [], public_facility: [], rule: [])
    end
    
end
