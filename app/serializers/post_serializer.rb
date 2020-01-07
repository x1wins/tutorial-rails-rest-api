class PostSerializer < ActiveModel::Serializer
  attributes :id, :body
  has_one :user
  has_many :comments
  def comments
    object.comments.where(published: true).order('created_at DESC, id DESC')
  end
end
