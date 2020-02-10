module Api
  module V1
    class CategoriesController < ApplicationController
      include CategoryHelper
      before_action :authorize_request
      before_action :post_pagination_params, only: [:index, :show]
      before_action except: [:index, :show] do
        is_role :admin
      end
      before_action :set_category, only: [:show, :update, :destroy]
      before_action only: [:edit, :update, :destroy] do
        is_owner_object @category ##your object
      end

      # GET /categories
      def index
        page = params[:page].presence || 1
        per = params[:per].presence || Pagination.per
        pagaination_param = {
            category_page: page,
            category_per: per,
            post_page: @post_page,
            post_per: @post_per
        }
        @categories = fetch_categories pagaination_param
        render json: @categories
      end

      # GET /categories/1
      def show
        pagaination_param = {
            post_page: @post_page,
            post_per: @post_per
        }
        render json: @category, pagaination_param: pagaination_param
      end

      # POST /categories
      def create
        @category = Category.new(category_params)

        if @category.save
          render json: @category, status: :created, location:  api_v1_category_url(@category)
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /categories/1
      def update
        if @category.update(category_params)
          render json: @category
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      # DELETE /categories/1
      def destroy
        @category.published = false
        @category.save
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_category
          @category = Category.published.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def category_params
          params.require(:category).permit(:title, :body).merge(user_id: @current_user.id)
        end

        def post_pagination_params
          @post_page = params[:post_page].presence || 1
          @post_per = params[:post_per].presence || Pagination.per
        end
    end
  end
end