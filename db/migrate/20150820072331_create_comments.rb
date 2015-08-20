class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      #t.references :comment, index: true, foreign_key: true
      t.integer :author_id
      t.references :commentable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
