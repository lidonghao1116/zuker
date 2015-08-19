class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.string :content
      t.references :sms_confirmable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
