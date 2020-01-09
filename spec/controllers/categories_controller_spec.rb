require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe CategoriesController, type: :controller do
  include ApiHelper

  let(:user){
    create(:user)
  }

  let(:categories){
    create_list(:category, 20, user: user)
  }

  let(:valid_attributes) {
    {title: "sample body", body: "sample body", user_id: user.id}
  }

  let(:invalid_attributes) {
    {title: "", body: "", user_id: user.id}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      category = Category.create! valid_attributes
      authenticated_header(request: request, user: user)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      category = Category.create! valid_attributes
      authenticated_header(request: request, user: user)
      get :show, params: {id: category.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        authenticated_header(request: request, user: user)
        expect {
          post :create, params: {category: valid_attributes}, session: valid_session
        }.to change(Category, :count).by(1)
      end

      it "renders a JSON response with the new category" do
        authenticated_header(request: request, user: user)
        post :create, params: {category: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(response.location).to eq(category_url(Category.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new category" do
        authenticated_header(request: request, user: user)
        post :create, params: {category: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {title: "sample title", body: "sample body 222", user_id: user.id}
      }

      it "updates the requested category" do
        category = Category.create! valid_attributes
        authenticated_header(request: request, user: user)
        put :update, params: {id: category.to_param, category: new_attributes}, session: valid_session
        category.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the category" do
        category = Category.create! valid_attributes
        authenticated_header(request: request, user: user)
        put :update, params: {id: category.to_param, category: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the category" do
        category = Category.create! valid_attributes
        authenticated_header(request: request, user: user)
        put :update, params: {id: category.to_param, category: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include('application/json')
      end
    end

    context "with invalid Authorize" do
      let(:another_user){
        create(:user)
      }
      it "renders a JSON response with errors (http code 403, Forbidden) for the post" do
        category = Category.create! valid_attributes
        authenticated_header(user: another_user, request: request)
        put :update, params: {id: category.to_param, post: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:forbidden)
        expect(response.content_type).to include('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      authenticated_header(user: another_user, request: request)
      expect {
        delete :destroy, params: {id: category.to_param}, session: valid_session
      }.to change(Category, :count).by(-1)
    end
  end

end
