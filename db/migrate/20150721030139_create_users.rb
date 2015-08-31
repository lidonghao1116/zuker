class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number, index: true, foreign_key: true
      t.string :password_digest
      t.boolean :verified, :default => false
      t.date :start_school_year
      t.boolean :sign_with_zuker
      t.references :school, index: true, foreign_key: true

      ### FB columns
      t.string :provider
      t.string :email
      t.string :uid, index: true, foreign_key: true
      t.string :image
      t.string :fb_url
      t.string :location
      t.string :school_name, array: true, default: []

      t.timestamps null: false
    end
  end
end
