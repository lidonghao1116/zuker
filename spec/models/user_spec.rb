require 'rails_helper'

RSpec.describe User, type: :model do
  it "擁有id、名字、電子郵件、電話號碼、預計畢業年度、密碼digest等欄位" do
    columns = User.column_names
    expect(columns).to include("id")
    expect(columns).to include("first_name")
    expect(columns).to include("last_name")
    expect(columns).to include("email")
    expect(columns).to include("phone_number")
    expect(columns).to include("start_school_year")
    expect(columns).to include("password_digest")
  end

  it "不能空白" do
    expect(User.new).not_to be_valid
  end

  describe "密碼介於6~20個字元且不可空白" do

    context "密碼格式錯誤" do

      it "密碼空白" do
        expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => "0920085181", :password => nil, :password_confirmation => nil)).not_to be_valid
      end

      it "密碼shorter than 6 words" do
        expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => "0920085182", :password => "12345", :password_confirmation => "12345")).not_to be_valid
      end

      it "密碼longer than 20 words" do
        expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => "0920085183", :password => "12345678901234567890123", :password_confirmation => "12345678901234567890123")).not_to be_valid
      end

    end

    context "密碼格式正確" do

      it "密碼介於6~20個字元且不空白" do
        expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => "0920085184", :password => "123456", :password_confirmation => "123456")).to be_valid
      end

    end

  end

  describe "註冊必須確認密碼" do

    context "密碼確認錯誤" do

      it "密碼確認空白" do
        expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => "0920085181", :password => "123456", :password_confirmation => nil)).to be_valid
      end

      it "密碼確認too short" do
        expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => "0920085181", :password => "123456", :password_confirmation => "123")).not_to be_valid
      end

      it "密碼確認too long" do
        expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => "0920085181", :password => "123456", :password_confirmation => "1234567890")).not_to be_valid
      end

    end

    it "密碼確認correct" do
      expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => "0920085181", :password => "123456", :password_confirmation => "123456")).to be_valid
    end

  end

  describe "姓名不可空白" do

    context "名" do

      it "名空白" do
        expect(User.new(:first_name => nil, :last_name => "thiel", :phone_number => "0920085183", :password => "123456")).not_to be_valid
      end

      it "名不空白" do
        expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => "0920085183", :password => "123456")).to be_valid
      end

    end

    context "姓" do

      it "姓空白" do
        expect(User.new(:first_name => "peter", :last_name => nil, :phone_number => "0920085183", :password => "123456")).not_to be_valid
      end

      it "姓不空白" do
        expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => "0920085183", :password => "123456")).to be_valid
      end

    end

  end

  describe "必須輸入正確格式的電話號碼" do

    context "電話格式錯誤" do
      it "電話空白" do
        expect(User.new(:first_name => "peter", :last_name => "thiel", :phone_number => nil, :password => "123456")).not_to be_valid
      end

      it "不符合09開頭" do
        test_user = User.new(:first_name => "username", :last_name => "thiel", :phone_number => "0800092000", :password => "password")
          expect(test_user).not_to be_valid
      end

      it "長度不符合10碼" do
        test_user3 = User.new(:first_name => "username", :last_name => "thiel", :phone_number => "0912345678910", :password => "password")
          expect(test_user3).not_to be_valid
      end

    end

    it "長度、開頭都符合" do
      test_user2 = User.new(:first_name => "username", :last_name => "thiel", :phone_number => "0920123456", :password => "password")
        expect(test_user2).to be_valid
    end

  end

  it "不可重複註冊同樣的電話號碼" do
    test_user = User.create(:first_name => "test1", :last_name => "thiel", :phone_number => "0920123456", :password => "password")
      expect(test_user).to be_valid
    dup_user = User.new(:first_name => "test2", :last_name => "thiel", :phone_number => "0920123456", :password => "other_password")
      expect(dup_user).not_to be_valid
  end

  describe "註冊完成後，可以利用密碼驗證機制確認密碼是否輸入正確" do
    before :each do
      @test_user = User.create(:first_name => "test1", :last_name => "thiel", :phone_number => "0920123456", :password => "correct_password")
    end

    it "密碼輸入正確" do
      expect(@test_user.authenticate("correct_password")).to eq @test_user
    end

    it "密碼輸入錯誤" do
      expect(@test_user.authenticate("incorrect_password")).to be false
    end

  end

  describe "密碼與某個使用者相同時，應該根據輸入的電話號碼回傳正確的使用者" do
    before :each do
      @test_user = User.create(:first_name => "test1", :last_name => "thiel", :phone_number => "0920123456", :password => "the_same_password")
      @test_user2 = User.create(:first_name => "test2", :last_name => "thiel", :phone_number => "0920654321", :password => "the_same_password")
    end

    it "根據號碼1回傳使用者1" do
      returned_user = User.find_by_phone_number(@test_user.phone_number).try(:authenticate, "the_same_password")
        expect(returned_user.full_name).to eq "test1 thiel"
    end

    it "根據號碼2回傳使用者2" do
      returned_user = User.find_by_phone_number(@test_user2.phone_number).try(:authenticate, "the_same_password")
        expect(returned_user.full_name).to eq "test2 thiel"
    end

  end

end
