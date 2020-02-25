class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  scope :post, lambda{ |post_id| where(post_id: post_id) if post_id.present? }
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('id DESC') }
  validates :body, presence: true
end
