class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :pagination
  has_one :user
  has_many :comments
  def comments
    comment_page = instance_options[:param_page][:comment_page].present? ? instance_options[:param_page][:comment_page] : 1
    comment_per = instance_options[:param_page][:comment_per].present? ? instance_options[:param_page][:comment_per] : 0
    object.comments.published.by_date.page(comment_page).per(comment_per)
  end
  def pagination
    comment_per = instance_options[:param_page][:comment_per].present? ? instance_options[:param_page][:comment_per] : 0
    Pagination.build_json(comments)[:pagination] if comment_per > 0
  end
end
