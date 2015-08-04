class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :title
      t.text :description
      t.string :location
      t.decimal :price

      t.timestamps null: false
    end
    change_column :rooms, :price, :decimal, :precision => 8, :scale => 2
  end
end
