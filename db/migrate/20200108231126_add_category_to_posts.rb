class AddCategoryToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :category, foreign_key: true
  end
end
