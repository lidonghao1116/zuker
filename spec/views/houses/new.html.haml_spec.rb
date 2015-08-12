require 'rails_helper'

RSpec.describe "houses/new", type: :view do
  before(:each) do
    assign(:house, House.new(
      :title => "MyString",
      :description => "MyText",
      :location => "MyString",
      :price => "9.99"
    ))
  end

  it "renders new house form" do
    render

    assert_select "form[action=?][method=?]", houses_path, "post" do

      assert_select "input#house_title[name=?]", "house[title]"

      assert_select "textarea#house_description[name=?]", "house[description]"

      assert_select "input#house_location[name=?]", "house[location]"

      assert_select "input#house_price[name=?]", "house[price]"
    end
  end
end
