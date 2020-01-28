class Category < ApplicationRecord
  belongs_to :user
  has_many :posts
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('created_at DESC, id DESC') }
  validates :title, presence: true
  validates :body, presence: true
end
