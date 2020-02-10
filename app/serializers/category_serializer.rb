class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :posts_pagination
  has_one :user
  has_many :posts
  def posts
    post_page = (instance_options.dig(:pagaination_param, :post_page).presence || 1).to_i
    post_per = (instance_options.dig(:pagaination_param, :post_per).presence || 10).to_i
    object.posts.published.by_date.page(post_page).per(post_per)
  end
  def posts_pagination
    post_per = (instance_options.dig(:pagaination_param, :post_per).presence || 10).to_i
    Pagination.build_json(posts)[:posts_pagination] if post_per > 0
  end
end
