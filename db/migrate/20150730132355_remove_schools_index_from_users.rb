class RemoveSchoolsIndexFromUsers < ActiveRecord::Migration
  def change
    remove_foreign_key :users, :schools
    remove_reference :users, :schools
  end
end
