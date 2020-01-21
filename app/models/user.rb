class User < ApplicationRecord
  has_secure_password
  has_many :assignments
  has_many :roles, through: :assignments
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end
end