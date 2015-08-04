class Room < ActiveRecord::Base
  mount_uploaders :images, ImageUploader
end
