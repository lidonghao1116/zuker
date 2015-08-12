require 'rails_helper'

RSpec.describe "houses/show", type: :view do
  before(:each) do
    @house = assign(:house, House.create!(
      :title => "Title",
      :description => "MyText",
      :location => "Location",
      :price => 9.99
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Location/)
    #expect(rendered).to eq(10) # set precision: 0 in show.html.haml
  end
end
