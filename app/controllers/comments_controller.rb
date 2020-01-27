class CommentsController < ApplicationController
  before_action :authorize_request
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action only: [:edit, :update, :destroy] do
    is_owner_object @comment ##your object
  end

  # GET /comments
  def index
    post_id = params[:post_id]
    page = params[:page].present? ? params[:page] : 1
    per = params[:per].present? ? params[:per] : 10
    @post = Post.published.find(post_id) if post_id.present?
    category_id = @post.category_id
    @category = Category.published.find(category_id)
    @comments = Comment.post(post_id).published.by_date.page(page).per(per)
    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.published = false
    @comment.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:body, :post_id).merge(user_id: @current_user.id)
    end
end
