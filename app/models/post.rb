class Post < ApplicationRecord
  include CategoryHelper
  include PostHelper
  belongs_to :category
  belongs_to :user
  has_many :comments
  has_many_attached :files
  scope :category, lambda{ |category_id| where(category_id: category_id) if category_id.present? }
  scope :search, lambda{ |search| self.where("title LIKE :search or body LIKE :search",  search: "%#{search}%") if search.present? }
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('id DESC') }
  validates :title, presence: true
  validates :body, presence: true
  after_save :clear_cache_posts
end
