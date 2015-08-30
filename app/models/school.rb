class School < ActiveRecord::Base

  include Imageable
  
  has_many :users, inverse_of: :school
  has_many :houses, inverse_of: :school

  def self.categories
    SchoolData.school_categories.map{ |k,v| [I18n.t("school_categories.#{k}"),v] }
  end
end
