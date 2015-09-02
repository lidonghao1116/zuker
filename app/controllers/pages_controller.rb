class PagesController < ApplicationController
  before_action :set_criteria, except: [:signin]
  #before_action :validate_search_key, only: [:search]

  layout 'panel'
  
  def home
    @schools = School.all
    @q = House.ransack(params[:q])
  end

  def signin ; end

  def search
    if params[:q].present?
      params[:q][@criteria] = params[:q][@criteria].gsub(/\\|\'|\/|\?/, "").split(" ") unless params[:q][@criteria].is_a?(Array)
    end
    @q = House.ransack(params[:q])

    @houses = @q.result(distinct: true).page params[:page]
    flash[:info] = 'Nothing found.' unless @houses.exists?
    render layout: 'application'
  end

  private

    def validate_search_key
      params[:q][@criteria] = params[:q][@criteria].gsub(/\\|\'|\/|\?/, "").split(" ") if params[:q].present?
    end

    def set_criteria
      @criteria = :title_or_description_cont_any
    end

end
