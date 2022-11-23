class AddUserIdToRatings < ActiveRecord::Migration[7.0]
  def change
    add_column :ratings, :user_id, :integer
    remove_column :ratings, :name
  end
end
