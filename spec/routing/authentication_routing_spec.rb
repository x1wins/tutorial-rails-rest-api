require "rails_helper"

RSpec.describe AuthenticationController, type: :routing do
  describe "routing" do
    it "routes to #login" do
      expect(:post => "/auth/login").to route_to("authentication#login")
    end
  end
end
