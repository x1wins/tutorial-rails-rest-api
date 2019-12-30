require 'json_web_token'

class ApplicationController < ActionController::API

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def is_owner user_id
    unless user_id == @current_user.id
      render json: nil, status: :forbidden
      return
    end
  end

  def is_owner_object data
    if data.nil? or data.user_id.nil?
      return render status: :not_found
    else
      is_owner data.user_id
    end
  end

end
