class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :body
      t.references :user, null: false, foreign_key: true
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
