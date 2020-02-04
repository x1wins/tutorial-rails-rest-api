require "rails_helper"

RSpec.describe Api::V1::AuthenticationController, type: :routing do
  describe "routing" do
    it "routes to #login" do
      expect(:post => "/api/v1/auth/login").to route_to("api/v1/authentication#login")
    end
  end
end
