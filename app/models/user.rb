class User < ApplicationRecord
  before_save { self.user_id = user_id.downcase }

  # User --> Post, posts of a user destroyed upon deleting a user
  has_many :posts, dependent: :destroy

  validates :user_id, presence: true, length: { in: 4...20 }, uniqueness: true
  validates :name, presence: true, length: { in: 1...20 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
