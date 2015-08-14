class School < ActiveRecord::Base
  has_many :users
  has_many :houses

  def self.categories
    SchoolData.school_categories.map{ |k,v| [I18n.t("school_categories.#{k}"),v] }
  end
end
