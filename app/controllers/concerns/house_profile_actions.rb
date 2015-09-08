module HouseProfileActions
  extend ActiveSupport::Concern
  
  included do
    layout "house_panel", only: [:basic, :amenity, :description, :photo, :date_status, :space, :rooms]
    before_action :no_validate, only: [:basic, :amenity, :description, :photo, :date_status]
    before_action :action_based_validation, only: [:basic, :amenity, :description, :photo, :date_status]
  end

  def basic
    authorize @house
    respond_to do |format|
      @prefix = "houses/profiles"
      format.html { render "#{@prefix}/#{action_name}" }
      format.js { render "#{@prefix}/#{action_name}"}
    end
  end

  def amenity
    authorize @house
    respond_to do |format|
      @prefix = "houses/profiles"
      format.html { render "#{@prefix}/#{action_name}" }
    end
  end

  def description
    authorize @house
    respond_to do |format|
      @prefix = "houses/profiles"
      format.html { render "#{@prefix}/#{action_name}" }
    end
  end

  def space
    if @house.family?
      authorize @house
      respond_to do |format|
        @prefix = "houses/profiles"
        format.html { render "#{@prefix}/#{action_name}" }
      end
    else        
      redirect_to rooms_house_path
    end
  end

  def photo
    if @house.family?
      authorize @house
      respond_to do |format|
        @prefix = "houses/profiles"
        format.html { render "#{@prefix}/#{action_name}" }
        format.js { render "#{@prefix}/#{action_name}"}
      end
    else        
      redirect_to rooms_house_path
    end
  end

  def date_status
    if @house.family?
      authorize @house
      respond_to do |format|
        @prefix = "houses/profiles"
        format.html { render "#{@prefix}/#{action_name}" }
        format.js { render "#{@prefix}/#{action_name}"}
      end
    else        
      redirect_to rooms_house_path
    end
  end

  def rooms
    respond_to do |format|
      @prefix = "houses/profiles"
      if @house.family?
        format.html { redirect_to basic_house_path }
      else
        @rooms = @house.rooms.all
        format.js { render "#{@prefix}/basic"}
        format.html { render "#{@prefix}/rooms" }
      end      
    end
  end

  private

    def no_validate
      session[:validate] = nil
    end

    def action_based_validation
      session[:validate] = action_name
    end

end