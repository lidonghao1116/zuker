class AddErrorTimesToPins < ActiveRecord::Migration
  def change
    add_column :pins, :error_times, :integer, :default => 0
  end
end