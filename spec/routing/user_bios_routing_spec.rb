require "rails_helper"

RSpec.describe UserBiosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_bios").to route_to("user_bios#index")
    end

    it "routes to #new" do
      expect(:get => "/user_bios/new").to route_to("user_bios#new")
    end

    it "routes to #show" do
      expect(:get => "/user_bios/1").to route_to("user_bios#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_bios/1/edit").to route_to("user_bios#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_bios").to route_to("user_bios#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/user_bios/1").to route_to("user_bios#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_bios/1").to route_to("user_bios#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_bios/1").to route_to("user_bios#destroy", :id => "1")
    end

  end
end
