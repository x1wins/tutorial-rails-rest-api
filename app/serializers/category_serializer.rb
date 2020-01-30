class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :pagination
  has_one :user
  has_many :posts
  def posts
    post_page = instance_options[:param_page][:post_page].present? ? instance_options[:param_page][:post_page] : 1
    post_per = instance_options[:param_page][:post_per].present? ? instance_options[:param_page][:post_per] : 10
    object.posts.published.by_date.page(post_page).per(post_per)
  end
  def pagination
    Pagination.build_json(posts)[:pagination]
  end
end
