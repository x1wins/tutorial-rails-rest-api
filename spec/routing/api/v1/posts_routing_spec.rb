require "rails_helper"

RSpec.describe Api::V1::PostsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/v1/posts").to route_to("api/v1/posts#index")
    end

    it "routes to #show" do
      expect(:get => "/api/v1/posts/1").to route_to("api/v1/posts#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/api/v1/posts").to route_to("api/v1/posts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/v1/posts/1").to route_to("api/v1/posts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/v1/posts/1").to route_to("api/v1/posts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/posts/1").to route_to("api/v1/posts#destroy", :id => "1")
    end
  end
end
