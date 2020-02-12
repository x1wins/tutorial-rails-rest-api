module Api
  module V1
    class PostsController < ApplicationController
      include PostHelper
      before_action :authorize_request
      before_action :comment_pagination_params, only: [:index, :show]
      before_action :set_post, only: [:show, :update, :destroy, :destroy_attached]
      before_action only: [:update, :destroy, :destroy_attached] do
        is_owner_object @post ##your object
      end

      # GET /posts
      def index
        category_id = params[:category_id]
        search = params[:search]
        page = params[:page].presence || 1
        per = params[:per].presence || Pagination.per
        @category = Category.published.find(category_id) if category_id.present?
        pagaination_param = {
            category_id: category_id,
            search: search,
            post_page: page,
            post_per: per,
            comment_page: @comment_page,
            comment_per: @comment_per
        }
        @posts = fetch_posts pagaination_param
        render json: @posts
      end

      # GET /posts/1
      def show
        pagaination_param = {
            comment_page: @comment_page,
            comment_per: @comment_per
        }
        render json: @post, pagaination_param: pagaination_param
      end

      # POST /posts
      def create
        @post = Post.new(post_params)
        set_category @post.category_id

        if @post.save
          render json: @post, status: :created, location: api_v1_post_url(@post)
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /posts/1
      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # DELETE /posts/1
      def destroy
        @post.published = false
        @post.save
      end

      # DELETE /posts/:id/attached/:id
      def destroy_attached
        attachment = ActiveStorage::Attachment.find(params[:attached_id])
        attachment.purge # or use purge_later
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def comment_pagination_params
          @comment_page = params[:comment_page].presence || 1
          @comment_per = params[:comment_per].presence || Pagination.per
        end

        def set_post
          @post = Post.published.find(params[:id])
          set_category @post.category_id
        end

        def set_category category_id
          @category = Category.published.find(category_id)
        end

        # Only allow a trusted parameter "white list" through.
        def post_params
            params.require(:post).permit(:body, :category_id, files: []).merge(user_id: @current_user.id)
        end
    end
  end
end
