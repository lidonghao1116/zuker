require "rails_helper"

RSpec.describe Users::HousesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "users/1/houses").to route_to("users/houses#index", user_id: '1')
    end

    it "routes to #new" do
      expect(:get => "users/1/houses/new").to route_to('users/houses#new', user_id: '1')
    end

    it "routes to #show" do
      expect(:get => "users/1/houses/1").to route_to("users/houses#show", user_id: '1', id: "1")
    end

    it "routes to #edit" do
      expect(:get => "users/1/houses/1/edit").to route_to("users/houses#edit", user_id: '1', :id => "1")
    end

    it "routes to #create" do
      expect(:post => "users/1/houses").to route_to("users/houses#create", user_id: '1')
    end

    it "routes to #update via PUT" do
      expect(:put => "users/1/houses/1").to route_to("users/houses#update", user_id: '1', :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "users/1/houses/1").to route_to("users/houses#update", user_id: '1', :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "users/1/houses/1").to route_to("users/houses#destroy", user_id: '1', :id => "1")
    end

  end
end
