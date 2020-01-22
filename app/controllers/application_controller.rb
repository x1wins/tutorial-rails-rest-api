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
      is_banned @current_user
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

  def append_info_to_payload(payload)
    super
    payload[:ip] = remote_ip(request)
    header payload
    if @current_user.present?
      begin
        user = User.find(@current_user.id)
        payload[:email] = user.email
        payload[:user_id] = user.id
      rescue ActiveRecord::RecordNotFound => e
        payload[:email] = ''
        payload[:user_id] = ''
      end
    end
  end

  def remote_ip(request)
    request.headers['HTTP_X_REAL_IP'] || request.remote_ip
  end

  def header payload
    headers = request.headers.env.select{|k, _| k.in?(ActionDispatch::Http::Headers::CGI_VARIABLES) || k =~ /^HTTP_/ }
    payload[:headers] = headers
  end

  def is_banned user
    if user.is? :banned
      render json: { error: 'banned' }, status: :unauthorized
    end
  end

end
