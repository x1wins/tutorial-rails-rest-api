require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :routing do

  let(:user){
    create(:user)
  }
  # let(:user) {
  #   create({user: {name: "aa", username:"aas", email: "x1wins@changwoo.net", password: "password123", password_confirmation: "password123"}})
  # }

  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/v1/users").to route_to("api/v1/users#index")
    end

    it "routes to #show" do
      expect(:get => "/api/v1/users/#{user.username}").to route_to("api/v1/users#show", :_username => user.username)
    end

    it "routes to #create" do
      expect(:post => "/api/v1/users").to route_to("api/v1/users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/v1/users/#{user.username}").to route_to("api/v1/users#update", :_username => user.username)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/v1/users/#{user.username}").to route_to("api/v1/users#update", :_username => user.username)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/users/#{user.username}").to route_to("api/v1/users#destroy", :_username => user.username)
    end
  end
end
