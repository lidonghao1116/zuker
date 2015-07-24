class Pin < ActiveRecord::Base
  belongs_to :sms_confirmable, polymorphic: true  
end
