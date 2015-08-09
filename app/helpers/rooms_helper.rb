module RoomsHelper
  def render_option_category(value, option)    
    key = RoomData.public_send("#{option}_categories").key(value)
    I18n.t("#{option}_categories.#{key}") if key
  end
end
