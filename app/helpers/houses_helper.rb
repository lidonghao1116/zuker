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

  def render_space(house)
    "#{house.bedroom}房#{house.bathroom}廳#{house.bathroom}衛#{house.balcony}陽台"
  end

  def render_book_btn(house)
    if house.not_available?
      #flash[:warning] = "This house is not available now."
      warning("This house is not available now.")
    else
      link_to 'Book Now', root_path, class: "btn btn-danger btn-lg"
    end
  end

end
