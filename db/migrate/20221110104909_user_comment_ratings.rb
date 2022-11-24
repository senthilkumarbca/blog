class UserCommentRatings < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_comment_ratings

    create_table :user_comment_ratings do |t|
      t.references :user
      t.references :comment
      t.integer :star

      t.timestamps
      end
  end
end
