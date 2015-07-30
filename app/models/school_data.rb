class SchoolData < Settingslogic
  source "#{Rails.root}/config/school_data.yml"
  namespace Rails.env
end