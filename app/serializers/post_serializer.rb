class PostSerializer < ActiveModel::Serializer
  attributes :id, :body
  has_one :user
  has_many :comments
  def comments
    comment_page = 1
    comment_per = 0
    param_page = instance_options[:param_page]
    if param_page
      comment_page = param_page[:comment_page].presence || comment_page
      comment_per = param_page[:comment_per].presence || comment_per
    end
    object.comments.published.by_date.page(comment_page).per(comment_per)
  end
end
