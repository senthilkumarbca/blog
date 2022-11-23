class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable

  has_many :posts
  has_many :comments
  has_many :ratings

  has_one :user_comment_ratings
  has_one :comments, through: :user_comment_ratings
end
