class AddColumnsToRoom < ActiveRecord::Migration
  def change
    change_table(:rooms) do |t|
      t.integer :room_type
      t.integer :direction
      t.integer :gender

      t.integer :amenity, array: true, default: []
      t.integer :furniture, array: true, default: []
      t.integer :extra_fee, array: true, default: []

      # t.integer :space
      # t.integer :building_level
      # t.integer :at_level

      # t.boolean :foreigner
      # t.boolean :parking_lot
      # t.boolean :security      
      # t.boolean :elevator
      # t.boolean :garbage
      # t.boolean :cooking
      # t.boolean :pet
      # Rails generates ? methods for all columns. They appear to return true only if the value is truthy. So this is a perfect match for booleans
    end
  end
end
