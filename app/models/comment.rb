class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('created_at DESC, id DESC') }
  validates :body, presence: true
end
