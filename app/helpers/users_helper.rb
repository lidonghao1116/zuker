module UsersHelper
  def render_start_school_years
    a = []
    Date.today.year.downto(Date.today.year-15) do |i| a << i end
    return a
  end
end
