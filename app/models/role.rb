class Role < ApplicationRecord
  has_many :assignments
  has_many :users, through: :assignments
  validates :name, presence: true, uniqueness: true
end
