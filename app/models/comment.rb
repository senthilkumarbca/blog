class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user, optional: true
  validates :user_id, presence: true

  has_many :user_comment_ratings
  has_many :user, through: :user_comment_ratings
end
