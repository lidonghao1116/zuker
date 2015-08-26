class Room < ActiveRecord::Base
  include Imageable
  
  belongs_to :house

  before_save :no_empty_array

  def no_empty_array
    amenity.reject! { |r| r.blank? }
    furniture.reject! { |r| r.blank? }
    safety.reject! { |r| r.blank? }
  end

end
