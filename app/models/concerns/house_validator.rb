class HouseValidator < ActiveModel::Validator
  def validate(house)
    if house.house_type == 1      
      house.errors[:bedroom] << "can't be zero." if house.bedroom.try(:zero?)      
      house.errors[:building_floor] << "can't be zero." if house.building_floor.try(:zero?)
    end
  end
end