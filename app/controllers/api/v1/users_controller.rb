module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: :create
      before_action :find_user, except: %i[create index]
      before_action only: [:index] do
        is_role :admin
      end
      before_action only: [:show, :update, :destroy] do
        is_owner @user.id ##your object
      end

      # GET /users
      def index
        @users = User.all
        render json: @users
      end

      # GET /users/{username}
      def show
        render json: @user
      end

      # POST /users
      def create
        @user = User.new(user_params)
        @user.avatar.attach(params[:user][:avatar]) if params.dig(:user, :avatar).present?
        if @user.save
          render json: @user, status: :created, location: api_v1_user_url(@user.username)
        else
          render json: { errors: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      # PUT /users/{username}
      def update
        @user.avatar.attach(params[:user][:avatar]) if params.dig(:user, :avatar).present?
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/{username}
      def destroy
        @user.destroy
      end

      private

      def find_user
        @user = User.find_by_username!(params[:_username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
      end

      def user_params
        params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
      end
    end
  end
end
