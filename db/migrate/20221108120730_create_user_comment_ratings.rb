class CreateUserCommentRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :user_comment_ratings do |t|
      t.references :user
      t.references :comment

      t.timestamps
    end
  end
end
