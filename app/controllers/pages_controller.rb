class PagesController < ApplicationController
  before_action :set_criteria, except: [:signin]
  before_action :validate_search_key

  layout 'homepage'
  
  def home
    @schools = School.all
    @q = House.ransack(params[:q])
  end

  def signin ; end

  def search
    @q = House.ransack(params[:q])

    @houses = @q.result(distinct: true).page params[:page]
    if @houses.exists?
      render layout: 'application'
    else
      flash[:alert] = 'Please search for other keywords'
      redirect_to :back
    end
  end

  private

    def validate_search_key
      params[:q][@criteria] = params[:q][@criteria].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    end

    def set_criteria
      @criteria = :title_or_description_cont
    end

end
