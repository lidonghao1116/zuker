class Room < ActiveRecord::Base
  mount_uploader :images, ImageUploader
end
