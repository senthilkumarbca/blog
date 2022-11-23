class AddNameToRatings < ActiveRecord::Migration[7.0]
  def change
    add_column :ratings, :name, :string
  end
end
