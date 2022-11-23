class Post < ApplicationRecord
  paginates_per 10
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
  has_many :ratings, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
  validates :topic_id, presence: true
  validates :user_id, presence: true

  scope :filter_by_date, -> (start_date, end_date) { where(created_at: start_date..end_date) }
  has_one_attached :image

  def update_avg_rating
    ratings_total = 0
    self.ratings.each { |r| ratings_total += r.star }
    ratings_count = self.ratings.size

    self.update_attribute(:avg_rating, (ratings_total.to_f / ratings_count.to_f).round(1))
  end
end
