module HousesHelper
  def render_house_category(value, option)
    key = HouseData.public_send("#{option}_categories").key(value)
    I18n.t("#{option}_categories.#{key}") if key
  end

  def render_description(max)
    ddd = []

    for i in (1..max).step(50) do
      ddd << "#{i.to_s.rjust(4, '0')}-#{(i+49).to_s.rjust(4, '0')}\r\n"
    end

    content_tag(:textarea, ddd.join(""))
  end

  def render_space(property)
    "#{property.bedroom}房#{property.bathroom}廳#{property.bathroom}衛#{property.balcony}陽台"
  end
end
