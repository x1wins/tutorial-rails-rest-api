class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments
  scope :category, lambda{ |category_id| where(category_id: category_id) if category_id.present? }
  scope :search, lambda{ |search| self.where("body LIKE ?", "%#{search}%") if search.present? }
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('created_at DESC, id DESC') }
  validates :body, presence: true
end
