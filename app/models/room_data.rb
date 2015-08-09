class RoomData < Settingslogic
  source "#{Rails.root}/config/room_data.yml"
  namespace Rails.env
end