class AddFbColumnsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :provider
      t.string :uid
      t.boolean :sign_with_zuker
    end
  end
end
