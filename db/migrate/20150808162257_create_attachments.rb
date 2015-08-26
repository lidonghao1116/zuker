class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :imageable, polymorphic: true, index: true
      t.string :image

      t.timestamps null: false
    end
  end
end
