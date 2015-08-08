class Room < ActiveRecord::Base
  has_many :attachments
  mount_uploaders :images, ImageUploader
end
