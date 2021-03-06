class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|      
      t.string :title, :city, :district, :address, :zipcode, :aasm_state
      t.boolean :hide_address
      t.text :description
      t.decimal :price, :precision => 8, :scale => 2 #### only family
      t.decimal :security_fee, :precision => 8, :scale => 2
      
      #### select and store as integer
      t.integer :school_id
      t.integer :house_type
      t.integer :gender
      t.integer :personal_parking_lot
      t.integer :foreigner
      t.integer :special_floor
      t.integer :min_lease #### only family
      t.integer :person, default: 1

      t.boolean :english_help      
      t.boolean :photo_help
      
      #### select and store as integer array
      t.integer :direction, array: true, default: []
      t.integer :amenity, array: true, default: []
      t.integer :furniture, array: true, default: []
      t.integer :extra_fee, array: true, default: []
      t.integer :public_facility, array: true, default: []
      t.integer :rule, array: true, default: []
      t.integer :safety, array: true, default: []

      #### input integer
      t.integer :building_floor
      t.integer :at_floor
      t.integer :area #### only family
      t.integer :bedroom #### only family
      t.integer :shared_space #### only family
      t.integer :bathroom #### only family
      t.integer :balcony #### only family

      t.references :user, null: false, index: true, foreign_key: true

      t.date :available_date
      t.date :reservable_date
      
      # Rails generates ? methods for all columns. They appear to return true only if the value is truthy. So this is a perfect match for booleans

      t.timestamps null: false
    end
  end
end
