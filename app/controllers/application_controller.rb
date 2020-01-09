require 'json_web_token'

class ApplicationController < ActionController::API
  rescue_from (ActiveRecord::RecordNotFound) { |exception| handle_exception(exception) }

  def handle_exception exception
    result = exception.message.match /Couldn't find ([\w]+) with 'id'=([\d]+)/
    if result.present? and result[1].present? and result[2].present?
      message = "Couldn't find #{result[1]} with id : #{result[2]} "
    else
      message = "Couldn't find"
    end
    handle_not_found message
  end
  def not_found
    message = "/#{params[:a]} Page Not Found"
    handle_not_found message
  end

  def handle_not_found message
    render json: { error: "#{message}" }, status: :not_found
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
