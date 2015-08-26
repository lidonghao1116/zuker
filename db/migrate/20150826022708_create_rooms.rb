class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :title

      t.integer :at_floor
      t.integer :special_floor

      t.integer :area

      t.integer :bedroom
      t.integer :bathroom
      t.integer :balcony

      t.integer :amenity, array: true, default: []
      t.integer :furniture, array: true, default: []
      t.integer :safety, array: true, default: []

      t.integer :min_lease
      t.decimal :price, :precision => 8, :scale => 2
      t.decimal :security_fee, :precision => 8, :scale => 2

      t.references :house, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
