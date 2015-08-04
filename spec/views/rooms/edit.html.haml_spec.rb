require 'rails_helper'

RSpec.describe "rooms/edit", type: :view do
  before(:each) do
    @room = assign(:room, Room.create!(
      :title => "MyString",
      :description => "MyText",
      :location => "MyString",
      :price => "9.99"
    ))
  end

  it "renders the edit room form" do
    render

    assert_select "form[action=?][method=?]", room_path(@room), "post" do

      assert_select "input#room_title[name=?]", "room[title]"

      assert_select "textarea#room_description[name=?]", "room[description]"

      assert_select "input#room_location[name=?]", "room[location]"

      assert_select "input#room_price[name=?]", "room[price]"
    end
  end
end
