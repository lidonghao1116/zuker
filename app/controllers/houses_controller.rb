class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update, :destroy]

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
        if params[:image]
          params[:image].each do |picture|
            @house.attachments.create(:image => picture)
            # Don't forget to mention :avatar(field name)
          end
        end
        format.html {
          redirect_to edit_house_path(@house)          
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
    if @house.update(house_params)
      if params[:image]
        params[:image].each do |picture|
          @house.attachments.create(:image => picture)
          # Don't forget to mention :avatar(field name)
        end
      end
      flash[:success] = t('flash.messages.success')
      redirect_to house_path(@house)

    else
      render :edit
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      params.require(:house).permit(:title, :description, :location, :price, :image, :house_type, :gender, :foreigner, :personal_parking_lot, amenity: [], furniture: [], extra_fee: [], public_facility: [], rule: [])
    end
end
