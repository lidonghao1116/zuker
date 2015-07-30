module UsersHelper
  def render_school_category(school)
    key = SchoolData.school_categories.key(school)
    I18n.t("school_categories.#{key}")
  end

  def render_start_school_years
    a = []
    Date.today.year.downto(Date.today.year-15) do |i| a << i end
    return a
  end
end
