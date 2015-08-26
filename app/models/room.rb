class Room < ActiveRecord::Base
  has_many :attachments
  belongs_to :house
end
