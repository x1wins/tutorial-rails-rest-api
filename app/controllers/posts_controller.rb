class PostsController < ApplicationController
  before_action :authorize_request
  before_action :set_post, only: [:show, :update, :destroy]
  before_action only: [:update, :destroy] do
    is_owner_object @post ##your object
  end

  # GET /posts
  def index
    category_id = params[:category_id]
    search = params[:search]
    page = params[:page].present? ? params[:page] : 1
    per = params[:per].present? ? params[:per] : 10
    @category = Category.published.find(category_id) if category_id.present?
    @posts = Post.category(category_id).search(search).published.by_date.page(page).per(per)
    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    set_category @post.category_id

    if @post.save
      render json: @post, status: :created, location: @post
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.published.find(params[:id])
      set_category @post.category_id
    end

    def set_category category_id
      @category = Category.published.find(category_id)
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
        params.require(:post).permit(:body, :category_id).merge(user_id: @current_user.id)
    end
end
