class CategoriesController < ApplicationController
  before_action :authorize_request
  before_action except: [:index, :show] do
    is_role :admin
  end
  before_action :set_category, only: [:show, :update, :destroy]
  before_action only: [:edit, :update, :destroy] do
    is_owner_object @category ##your object
  end

  # GET /categories
  def index
    @categories = Category.all

    render json: @categories
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
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
end
