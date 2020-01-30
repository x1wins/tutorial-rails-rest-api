class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :posts_pagination
  has_one :user
  has_many :posts
  def posts
    post_page = instance_options.dig(:pagaination_param, :post_page).presence.to_i || 1
    post_per = instance_options.dig(:pagaination_param, :post_per).presence.to_i || 10
    object.posts.published.by_date.page(post_page).per(post_per)
  end
  def posts_pagination
    post_per = instance_options.dig(:pagaination_param, :post_per).presence.to_i || 10
    Pagination.build_json(posts)[:pagination] if post_per > 0
  end
end
