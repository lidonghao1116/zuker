class ChangeColumnOfUsers < ActiveRecord::Migration
  def change
    rename_column :users, :expected_graduation_date, :start_school_year
  end
end
