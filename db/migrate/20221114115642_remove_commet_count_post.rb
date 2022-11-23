class RemoveCommetCountPost < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :comments_count
  end
end
