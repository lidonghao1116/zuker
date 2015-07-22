require 'rails_helper'

RSpec.describe User, type: :model do
  it "擁有id、名字、電子郵件、電話號碼、預計畢業年度、密碼digest等欄位" do
    columns = User.column_names
    expect(columns).to include("id")
    expect(columns).to include("name")
    expect(columns).to include("email")
    expect(columns).to include("phone_number")
    expect(columns).to include("expected_graduation_date")
    expect(columns).to include("password_digest")
  end

  it "不能空白" do
    expect(User.new).not_to be_valid
  end

  it "密碼介於6~20個字元且不可空白" do
    expect(User.new(:name => "peter", :phone_number => "0920085183", :password => nil)).not_to be_valid
    expect(User.new(:name => "peter", :phone_number => "0920085183", :password => "12345")).not_to be_valid
    expect(User.new(:name => "peter", :phone_number => "0920085183", :password => "12345678901234567890123")).not_to be_valid
    expect(User.new(:name => "peter", :phone_number => "0920085183", :password => "123456")).to be_valid
  end

  it "姓名不可空白" do
    expect(User.new(:name => "peter", :phone_number => "0920085183", :password => "123456")).to be_valid
    expect(User.new(:name => nil, :phone_number => "0920085183", :password => "123456")).not_to be_valid
  end

  it "電話不可空白" do
    expect(User.new(:name => "peter", :phone_number => nil, :password => "123456")).not_to be_valid
  end

  it "必須輸入正確格式的電話號碼" do
    test_user = User.new(:name => "username", :phone_number => "0800092000", :password => "password")
    expect(test_user).not_to be_valid
    test_user2 = User.new(:name => "username", :phone_number => "0920123456", :password => "password")
    expect(test_user2).to be_valid
  end

  it "不可重複註冊同樣的電話號碼" do
    test_user = User.create(:name => "test1", :phone_number => "0920123456", :password => "password")
    expect(test_user).to be_valid
    expect(User.new(:name => "test2", :phone_number => "0920123456", :password => "other_password")).not_to be_valid
  end

  it "註冊完成後，可以利用密碼驗證機制確認密碼是否輸入正確" do
    test_user = User.new(:name => "test1", :phone_number => "0920123456", :password => "correct_password")
      expect(test_user).to be_valid
    test_user.save
      expect(test_user.authenticate("incorrect_password")).to be false
      expect(test_user.authenticate("correct_password")).to eq test_user
  end

  it "密碼與某個使用者相同時，應該根據輸入的電話號碼回傳正確的使用者" do
    test_user = User.create(:name => "test1", :phone_number => "0920123456", :password => "the_same_password")
    test_user2 = User.create(:name => "test2", :phone_number => "0920654321", :password => "the_same_password")

    returned_user = User.find_by_phone_number(test_user.phone_number).try(:authenticate, "the_same_password")
      expect(returned_user.name).to eq "test1"

    returned_user = User.find_by_phone_number(test_user2.phone_number).try(:authenticate, "the_same_password")
      expect(returned_user.name).to eq "test2"
  end

end
