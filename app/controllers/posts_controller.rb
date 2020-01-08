class PostsController < ApplicationController
  before_action :authorize_request
  before_action :set_post, only: [:show, :update, :destroy]
  before_action only: [:edit, :update, :destroy] do
    is_owner_object @post ##your object
  end

  # GET /posts
  def index
    search = params[:search]
    @posts = Post.search(search).published.by_date
    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

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
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
        params.require(:post).permit(:body).merge(user_id: @current_user.id)
    end
end
