module UsersHelper
  def render_school_category(school)
    key = SchoolData.school_categories.key(school.school_category)
    I18n.t("school_categories.#{key}")
  end
end
