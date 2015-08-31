class PagesController < ApplicationController
  layout 'homepage'
  
  def home
    @schools = School.all
  end
  def signin    
  end
end
