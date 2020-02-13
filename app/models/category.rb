class Category < ApplicationRecord
  include CategoryHelper
  belongs_to :user
  has_many :posts
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('created_at DESC, id DESC') }
  validates :title, presence: true
  validates :body, presence: true
  after_save :clear_cache_categories
end
