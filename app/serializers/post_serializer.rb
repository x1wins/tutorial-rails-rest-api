class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :comments_pagination
  has_one :user
  has_many :comments
  def comments
    comment_page = instance_options.dig(:pagaination_param, :comment_page).presence.to_i || 1
    comment_per = instance_options.dig(:pagaination_param, :comment_per).presence.to_i || 0
    object.comments.published.by_date.page(comment_page).per(comment_per)
  end
  def comments_pagination
    comment_per = instance_options.dig(:pagaination_param, :comment_per).presence.to_i || 0
    Pagination.build_json(comments)[:comments_pagination] if comment_per > 0
  end
end
