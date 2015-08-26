class Room < ActiveRecord::Base
  include Imageable
  
  belongs_to :house
end
