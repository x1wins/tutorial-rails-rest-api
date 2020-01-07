class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :body, presence: true
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('created_at DESC, id DESC') }
end
