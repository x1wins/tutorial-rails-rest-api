require 'rails_helper'

RSpec.describe "Posts", type: :request do
  include ApiHelper

  let(:user){
    create(:user)
  }

  describe "GET /posts" do
    it "works! (now write some real specs)" do
      headers = authenticated_headers(user)
      get posts_path, headers: headers
      expect(response).to have_http_status(200)
    end
  end
end
