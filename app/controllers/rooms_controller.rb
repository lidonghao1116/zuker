class RoomsController < ApplicationController
  before_action :set_house

  def new
    @room = @house.rooms.new
  end

  def create
    @room = @house.rooms.new(room_params)
    respond_to do |format|
      if @room.save
        format.html {
          flash[:success] = t('flash.messages.success')
          redirect_to space_house_path(@house)
        }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_house
      @house = House.find(params[:house_id])
    end

    def room_params
      params.require(:room).permit(:price, :available_date, :reservable_date, :area, :building_floor, :at_floor, :special_floor, :direction, :bedroom, :bathroom, :balcony, :min_lease, :security_fee, amenity: [], furniture: [])
    end
end
