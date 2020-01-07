class ChangePublishedDefaultToPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :published, :boolean, default: true
  end
end
