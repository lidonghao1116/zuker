require 'rails_helper'

RSpec.describe User, type: :model do
  it "has id, name, email, phone_number and password_digest columns" do
    columns = User.column_names
    expect(columns).to include("id")
    expect(columns).to include("name")
    expect(columns).to include("email")
    expect(columns).to include("phone_number")
    expect(columns).to include("password_digest")
  end

  it "can't be empty" do
    expect(User.new).not_to be_valid
  end

  it "validates password length and presence" do
    expect(User.new(:name => "peter", :phone_number => "0920085183", :password => nil)).not_to be_valid
    expect(User.new(:name => "peter", :phone_number => "0920085183", :password => "12345")).not_to be_valid
    expect(User.new(:name => "peter", :phone_number => "0920085183", :password => "12345678901234567890123")).not_to be_valid
    expect(User.new(:name => "peter", :phone_number => "0920085183", :password => "123456")).to be_valid
  end

  it "validates name" do
    expect(User.new(:name => "peter", :phone_number => "0920085183", :password => "123456")).to be_valid
    expect(User.new(:name => nil, :phone_number => "0920085183", :password => "123456")).not_to be_valid
  end

  it "validates phone_number" do
    expect(User.new(:name => "peter", :phone_number => nil, :password => "123456")).not_to be_valid
  end

  it "can validate password is correct or not" do
    test_user = User.new(:name => "test1", :phone_number => "0920123456", :password => "correct_password")
      expect(test_user).to be_valid
    test_user.save
      expect(test_user.authenticate("incorrect_password")).to be false
      expect(test_user.authenticate("correct_password")).to eq test_user
  end

  it "should return right user if password is correct" do
    test_user = User.create(:name => "test1", :phone_number => "0920123456", :password => "the_same_password")
    test_user2 = User.create(:name => "test2", :phone_number => "0920654321", :password => "the_same_password")

    returned_user = User.find(test_user.id).try(:authenticate, "correct_password")
      expect(returned_user.name).to eq "test1"

    returned_user = test_user2.authenticate("correct_password2")
      expect(returned_user.name).to eq "test1"
  end
end
