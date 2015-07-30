class AddSchoolReferenceToUsers < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name

      t.timestamps null: false
    end
    add_reference :users, :school, index: true, foreign_key: true
  end
end
