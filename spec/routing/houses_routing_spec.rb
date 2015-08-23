require "rails_helper"

RSpec.describe HousesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/houses").to route_to("houses#index")
    end

    it "routes to #new" do
      expect(:get => "/houses/new").not_to be_routable
    end

    it "routes to #show" do
      expect(:get => "/houses/1").to route_to("houses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/houses/1/edit").not_to be_routable
    end

    it "routes to #create" do
      expect(:post => "/houses").not_to be_routable
    end

    it "routes to #update via PUT" do
      expect(:put => "/houses/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/houses/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(:delete => "/houses/1").not_to be_routable
    end

  end
end
