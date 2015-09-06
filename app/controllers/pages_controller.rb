class PagesController < ApplicationController
  before_action :set_criteria, except: [:signin]
  #before_action :validate_search_key, only: [:search]

  layout 'panel'
  
  def menu
    
  end

  def home
    @schools = School.all
    @q = House.ransack(params[:q])
  end

  def signin ; end

  def search
    @q = House.ransack(params[:q])
    @abc = rand(1..10)
    @houses = @q.result(distinct: true).page params[:page]
    flash[:info] = 'Nothing found.' unless @houses
    render layout: 'application'
  end

  private

    def validate_search_key
      params[:q][@criteria] = params[:q][@criteria].gsub(/\\|\'|\/|\?/, "").split(" ") unless params[:q][@criteria].is_a?(Array) if params[:q][@criteria].present?
    end

    def set_criteria
      @criteria = :title_or_description_cont_any
    end

end
