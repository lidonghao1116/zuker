class House < ActiveRecord::Base

  paginates_per 3

  include Commentable
  include Imageable
  include AASM

  belongs_to :school, inverse_of: :houses
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :rooms

  before_save :no_empty_array

  def no_empty_array
    amenity.reject! { |r| r.blank? }
    furniture.reject! { |r| r.blank? }
    extra_fee.reject! { |r| r.blank? }
    safety.reject! { |r| r.blank? }
    public_facility.reject! { |r| r.blank? }
    rule.reject! { |r| r.blank? }
  end

  def self.option_categories(option)
    HouseData.public_send("#{option}_categories").map{ |k,v| [I18n.t("#{option}_categories.#{k}"),v] }
  end

  def family?
    house_type == 1
  end

  attr_accessor :validate

  with_options if: "validate == 'date_status'" do |z|
    z.validate :reservable_before_available
  end
  
  validates_presence_of :house_type, :foreigner, :school_id, :city, :district, :zipcode, :address
  validates_with HouseValidator

  with_options if: "validate == 'description'" do |z|
    z.validates :title, presence: true, length: { in: 2..25 }, allow_blank: true
    z.validates :description, length: { in: 5..2000 }, allow_blank: true
  end

  def reservable_before_available
    if reservable_date && available_date
      if reservable_date > available_date
        errors.add(:reservable_date, "can't be later than available_date")
        errors.add(:available_date, "can't be earlier than reservable_date")
        false
      else
        true
      end
    end
  end

  before_save :update_status, if: "validate == 'date_status'"

  def update_status
    if Time.now >= available_date
      self.ready if self.may_ready?
    elsif Time.now >= reservable_date
      self.come if self.may_come?
    else
      self.hide if self.may_hide?
    end      
  end

  aasm :whiny_transitions => false do
    state :not_available, :initial => true
    state :coming
    state :available

    event :ready do
      transitions :from => [:not_available, :coming], :to => :available do
        guard do 
          Time.now >= available_date
        end
      end
    end

    event :come do
      transitions :from => [:available, :not_available], :to => :coming do
        guard do
          Time.now < available_date && Time.now >= reservable_date
        end
      end
    end

    event :hide do
      transitions :from => [:coming, :available], :to => :not_available do
        guard do 
          Time.now < reservable_date
        end
      end
    end

    event :rent do
      transitions :from => :available, :to => :not_available
    end
  end

end
