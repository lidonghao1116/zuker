require 'rails_helper'

RSpec.describe "houses/edit", type: :view do
  before(:each) do
    @house = assign(:house, House.create!(
      :title => "MyString",
      :description => "MyText",
      :location => "MyString",
      :price => "9.99"
    ))
  end

  it "renders the edit house form" do
    render

    assert_select "form[action=?][method=?]", house_path(@house), "post" do

      assert_select "input#house_title[name=?]", "house[title]"

      assert_select "textarea#house_description[name=?]", "house[description]"

      assert_select "input#house_location[name=?]", "house[location]"

      assert_select "input#house_price[name=?]", "house[price]"
    end
  end
end
