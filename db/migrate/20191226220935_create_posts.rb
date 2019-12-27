class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :body
      t.references :user, null: false, foreign_key: true
      t.boolean :published

      t.timestamps
    end
  end
end
