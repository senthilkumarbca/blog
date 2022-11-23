class AddStar < ActiveRecord::Migration[7.0]
  def change
    add_column :user_comment_ratings, :star, :integer
  end
end
