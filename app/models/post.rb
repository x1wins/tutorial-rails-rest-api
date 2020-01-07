class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  scope :search, lambda{ |keyword| self.where("body LIKE ?", "%#{keyword}%") if keyword.present? }
  scope :published, -> { where(published: true) }
  scope :by_date, -> { order('created_at DESC, id DESC') }
  validates :body, presence: true
end
