class House < ActiveRecord::Base
  has_many :attachments
  belongs_to :school
  #validates :title, presence: true, length: { in: 2..20 }
  #validates :description, length: { in: 20..200 }
  before_save :no_empty_array

  def no_empty_array
    amenity.reject! { |r| r.blank? }
    furniture.reject! { |r| r.blank? }
    extra_fee.reject! { |r| r.blank? }
  end

  def self.option_categories(option)
    HouseData.public_send("#{option}_categories").map{ |k,v| [I18n.t("#{option}_categories.#{k}"),v] }
  end
end
