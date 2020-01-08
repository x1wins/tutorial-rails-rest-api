class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :published
  has_one :user
end
