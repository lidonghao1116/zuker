module HousesHelper
  def render_option_category(value, option)    
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
end
