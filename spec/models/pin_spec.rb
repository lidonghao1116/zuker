require 'rails_helper'

RSpec.describe Pin, type: :model do
  it "擁有id & content欄位" do
    columns = Pin.column_names
    expect(columns).to include("id")
    expect(columns).to include("content")
    expect(columns).to include("sms_confirmable_id")
    expect(columns).to include("sms_confirmable_type")
  end
end
