class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :house, index: true, foreign_key: true
      t.string :image

      t.timestamps null: false
    end
  end
end
