require "rails_helper"

RSpec.describe UsersController, type: :routing do

  let(:user){
    create(:user)
  }
  # let(:user) {
  #   create({user: {name: "aa", username:"aas", email: "x1wins@changwoo.net", password: "password123", password_confirmation: "password123"}})
  # }

  describe "routing" do
    it "routes to #index" do
      expect(:get => "/users").to route_to("users#index")
    end

    it "routes to #show" do
      expect(:get => "/users/#{user.username}").to route_to("users#show", :_username => user.username)
    end

    it "routes to #create" do
      expect(:post => "/users").to route_to("users#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/users/#{user.username}").to route_to("users#update", :_username => user.username)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/users/#{user.username}").to route_to("users#update", :_username => user.username)
    end

    it "routes to #destroy" do
      expect(:delete => "/users/#{user.username}").to route_to("users#destroy", :_username => user.username)
    end
  end
end
