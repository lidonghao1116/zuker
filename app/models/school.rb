class School < ActiveRecord::Base
  has_many :users

  def self.categories
    SchoolData.school_categories.map{ |k,v| [I18n.t("school_categories.#{k}"),v] }
  end
end
