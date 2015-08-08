class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :title
      t.text :description
      t.string :location
      t.decimal :price, :precision => 8, :scale => 2
      t.string :image

      t.timestamps null: false
    end
  end
end
