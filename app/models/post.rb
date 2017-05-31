class Post < ApplicationRecord
  belongs_to :user
  # order by created_at by default
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
end
