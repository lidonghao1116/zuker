class HouseValidator < ActiveModel::Validator
  def validate(house)
    if house.house_type == 1
      unless house.bedroom > 0
        house.errors[:bedroom] << "can't be zero."
      end
      unless house.building_floor > 0
        house.errors[:building_floor] << "can't be zero."
      end
    end
  end
end