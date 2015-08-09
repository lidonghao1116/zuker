class Attachment < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :room
end
