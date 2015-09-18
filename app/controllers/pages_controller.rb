class PagesController < ApplicationController
  before_action :set_criteria, except: [:signin]
  #before_action :validate_search_key, only: [:search]

  def home
    @schools = School.all
    @q = House.ransack(params[:q])
  end

  def signin
    #render layout: 'panel'
    respond_to do |format|
      format.js
      format.html
    end
  end

  def search
    @q = House.ransack(params[:q])
    @houses = @q.result.page(params[:page])#.to_a.uniq
    flash.now[:info] = 'Nothing found.' if @houses.size.zero?
  end

  private

    def validate_search_key
      params[:q][@criteria] = params[:q][@criteria].gsub(/\\|\'|\/|\?/, "").split(" ") unless params[:q][@criteria].is_a?(Array) if params[:q][@criteria].present?
    end

    def set_criteria
      @criteria = :title_or_description_cont_any
    end

end
