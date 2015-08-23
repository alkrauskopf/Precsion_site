require "rails_helper"

RSpec.describe UserClassesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_classes").to route_to("user_classes#index")
    end

    it "routes to #new" do
      expect(:get => "/user_classes/new").to route_to("user_classes#new")
    end

    it "routes to #show" do
      expect(:get => "/user_classes/1").to route_to("user_classes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_classes/1/edit").to route_to("user_classes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_classes").to route_to("user_classes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/user_classes/1").to route_to("user_classes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_classes/1").to route_to("user_classes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_classes/1").to route_to("user_classes#destroy", :id => "1")
    end

  end
end
