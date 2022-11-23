class Rating < ApplicationRecord
  validates :user_id, :star, presence: true
  validates_uniqueness_of :post_id, scope: :user_id
  belongs_to :post
  belongs_to :user

  after_create :update_post_rating

  def update_post_rating
    post.update_avg_rating
  end
end
