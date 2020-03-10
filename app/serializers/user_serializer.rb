class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :username, :email, :avatar
  def avatar
    if object.avatar.attachment
      url = rails_blob_url(object.avatar)
      # url.sub 'localhost', 'rhee03.ngrok.io'
    else
      "https://www.gravatar.com/avatar/00000000000000000000000000000000"
    end
  end
end
