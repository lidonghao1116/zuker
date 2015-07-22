class AddGraduationToUser < ActiveRecord::Migration
  def change
    add_column :users, :expected_graduation_date, :date
  end
end
