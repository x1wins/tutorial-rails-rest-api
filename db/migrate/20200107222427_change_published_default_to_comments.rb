class ChangePublishedDefaultToComments < ActiveRecord::Migration[6.0]
  def change
    change_column :comments, :published, :boolean, default: true
  end
end
