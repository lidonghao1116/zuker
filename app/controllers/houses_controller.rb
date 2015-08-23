class HousesController < ApplicationController

  before_action :set_house, except: [:index, :new, :create]

  include CommentableActions

  # GET /houses
  # GET /houses.json
  def index
    @houses = House.all.page params[:page]
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
    @comments = @house.comments.page params[:page]
  end

  # GET /houses/new
  def new
    @house = House.new
    session[:validate] = "basic"
  end


private

    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      params.require(:house).permit(:title, :description, :price, :image, :house_type, :gender, :foreigner, :english_help, :photo_help, :city, :district, :address, :zipcode, :hide_address, :personal_parking_lot, :available_date, :reservable_date, :area, :building_floor, :at_floor, :special_floor, :direction, :bedroom, :shared_space, :bathroom, :balcony, :school_id, :min_lease, :security_fee, safety: [], amenity: [], furniture: [], extra_fee: [], public_facility: [], rule: [])
    end
end
