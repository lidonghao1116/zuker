class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :title
      t.text :description
      t.string :location
      t.decimal :price, :precision => 8, :scale => 2
      t.json :images
      
      t.integer :house_type
      t.integer :gender
      t.integer :personal_parking_lot
      t.integer :english
      
      t.integer :direction, array: true, default: []
      t.integer :amenity, array: true, default: []
      t.integer :furniture, array: true, default: []
      t.integer :extra_fee, array: true, default: []
      t.integer :public_facility, array: true, default: []
      t.integer :rule, array: true, default: []      

      # t.integer :space
      # t.integer :building_floor
      # t.integer :at_floor
      # t.integer :security_fee
      
      # Rails generates ? methods for all columns. They appear to return true only if the value is truthy. So this is a perfect match for booleans

      t.timestamps null: false
    end
  end
end
