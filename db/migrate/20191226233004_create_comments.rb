class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :published

      t.timestamps
    end
  end
end
