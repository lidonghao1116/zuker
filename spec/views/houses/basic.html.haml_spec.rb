require 'rails_helper'

RSpec.describe "houses/profiles/basic", type: :view do
  before(:each) do
    @user = User.create(first_name: "peter1", last_name: "thiel", phone_number: "0920085181", password: "123456")
    
    @house = assign(:house, @user.houses.create!(
      house_type: '2',
      #user_id: @user_1.id,
      :title => "MyString",
      :description => "MyText",
      :address => "MyString",
      :price => "9.99"
    ))
  end

  it "renders the basic house form" do
    render

    assert_select "form[action=?][method=?]", house_path(@house), "post" do

      # assert_select "input#house_title[name=?]", "house[title]"

    #   #assert_select "textarea#house_description[name=?]", "house[description]"

      assert_select "input#house_house_type[name=?]", "house[house_type]"

      assert_select "input#house_special_floor[name=?]", "house[special_floor]"

      assert_select "input#house_foreigner[name=?]", "house[foreigner]"      

      assert_select "input#house_address[name=?]", "house[address]"

      assert_select "input#house_price[name=?]", "house[price]"
    end
  end
end
