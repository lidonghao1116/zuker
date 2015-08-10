class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        if params[:image]
          params[:image].each do |picture|
            @room.attachments.create(:image => picture)
            # Don't forget to mention :avatar(field name)
          end
        end
        format.html {
          redirect_to edit_room_path(@room)          
          flash[:success] = t('flash.messages.success')
        }
        format.json { render :json => @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    if @room.update(room_params)
      if params[:image]
        params[:image].each do |picture|
          @room.attachments.create(:image => picture)
          # Don't forget to mention :avatar(field name)
        end
      end
      flash[:success] = t('flash.messages.success')
      redirect_to room_path(@room)

    else
      render :edit
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:title, :description, :location, :price, :image, :room_type, :gender, amenity: [], furniture: [], extra_fee: [])
    end
end
