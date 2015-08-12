class HouseData < Settingslogic
  source "#{Rails.root}/config/house_data.yml"
  namespace Rails.env
end