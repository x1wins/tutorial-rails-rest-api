class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  has_one :user
  has_many :posts
  def posts
    post_page = 1
    post_per = 10
    param_page = instance_options[:param_page]
    if param_page
      post_page = param_page[:post_page].presence || post_page
      post_per = param_page[:post_per].presence || post_per
    end
    object.posts.published.by_date.page(post_page).per(post_per)
  end
end
