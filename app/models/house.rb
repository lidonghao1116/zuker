class House < ActiveRecord::Base

  paginates_per 3

  include Commentable
  
  attr_accessor :validate

  belongs_to :school, inverse_of: :houses
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many :attachments
  
  with_options if: "validate == 'basic'" do |z|
    z.validates_presence_of :house_type, :special_floor, :foreigner, :school_id, :city, :district, :zipcode, :address
    z.validates_with HouseValidator
  end
  with_options if: "validate == 'description'" do |z|
    z.validates :title, presence: true, length: { in: 2..20 }
    z.validates :description, length: { in: 20..200 }, allow_blank: true
  end

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
