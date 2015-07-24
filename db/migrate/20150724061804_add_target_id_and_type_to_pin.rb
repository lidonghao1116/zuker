class AddTargetIdAndTypeToPin < ActiveRecord::Migration
  def change
    add_column :pins, :sms_confirmable_id, :integer
    add_column :pins, :sms_confirmable_type, :string
  end
end
