class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|      
      t.string :title
      t.text :description
      t.string :location
      t.boolean :hide_location
      t.decimal :price, :precision => 8, :scale => 2 #### only family
      t.decimal :security_fee, :precision => 8, :scale => 2, default: 0
      t.json :images
      
      #### select and store as integer
      t.integer :school_id
      t.integer :house_type
      t.integer :gender
      t.integer :personal_parking_lot
      t.integer :english
      t.integer :special_floor
      t.integer :min_lease #### only family
      
      #### select and store as integer array
      t.integer :direction, array: true, default: []
      t.integer :amenity, array: true, default: []
      t.integer :furniture, array: true, default: []
      t.integer :extra_fee, array: true, default: []
      t.integer :public_facility, array: true, default: []
      t.integer :rule, array: true, default: []
      t.integer :safety, array: true, default: []

      #### input integer
      # t.integer :space model or array? #### only family
      t.integer :area #### only family
      t.integer :building_floor
      t.integer :at_floor

      # t.date :unavailable_date
      # t.boolean :unavailable
      
      # Rails generates ? methods for all columns. They appear to return true only if the value is truthy. So this is a perfect match for booleans

      t.timestamps null: false
    end
  end
end
