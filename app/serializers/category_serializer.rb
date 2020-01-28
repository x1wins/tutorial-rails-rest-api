class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :body
  has_one :user
  has_many :posts
  def posts
    post_page = instance_options[:post_page].presence || 1
    post_per = instance_options[:post_per].presence || 10
    object.posts.published.by_date.page(post_page).per(post_per)
  end
end
