class Room < ActiveRecord::Base
  has_many :attachments
  validates :title, presence: true
  before_save :no_empty_array

  def no_empty_array
    amenity.reject! { |r| r.blank? }
    furniture.reject! { |r| r.blank? }
    extra_fee.reject! { |r| r.blank? }
  end

  def self.option_categories(option)
    RoomData.public_send("#{option}_categories").map{ |k,v| [I18n.t("#{option}_categories.#{k}"),v] }
  end

  def self.school_categories
    SchoolData.school_categories.map{ |k,v| [I18n.t("school_categories.#{k}"),v] }
  end
end
