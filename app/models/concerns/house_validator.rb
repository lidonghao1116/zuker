class HouseValidator < ActiveModel::Validator
  def validate(house)
    if house.house_type == 1      
      house.errors[:bedroom] << "can't be zero." if house.bedroom.try(:zero?)
      house.errors[:building_floor] << "can't be zero." if house.building_floor.try(:zero?)
      house.errors[:at_floor] << "can't be zero." if house.at_floor && house.at_floor < 1
    end
  end
end