module SchoolsHelper
  def render_school_category(school)
    key = SchoolData.school_categories.key(school)
    I18n.t("school_categories.#{key}") if key
  end
end
