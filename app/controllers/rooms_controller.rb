class RoomsController < ApplicationController
  before_action :set_house
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def new
    @room = @house.rooms.new
    authorize @room
  end

  def create
    @room = @house.rooms.new(room_params)
    respond_to do |format|
      if @room.save
        params[:image].try(:each) do |picture|
          @room.attachments.create(:image => picture)
        end
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

  def edit
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        params[:image].try(:each) do |picture|
          @room.attachments.create(:image => picture)
        end
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
    def set_room
      @room = @house.rooms.find(params[:id])
    end

    def set_house
      @house = House.find(params[:house_id])
    end

    def room_params
      params.require(:room).permit(:available_date, :reservable_date, :area, :at_floor, :special_floor, :direction, :bedroom, :bathroom, :balcony, :min_lease, :price, :security_fee, amenity: [], furniture: [], safety: [])
    end
end
