# spec/support/api_helper.rb
module ApiHelper
  def authenticated_header(request, user)
    token = JsonWebToken.encode(user_id: user.id)
    request.headers.merge!('Authorization': "Bearer #{token}")
  end
end