class User < ApplicationRecord
  has_many :recipes
  validates :username, :password_digest, presence: true, uniqueness: true
end
