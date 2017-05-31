class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :post_type
      t.string :title
      t.boolean :is_public
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :posts, [ :user_id, :post_type, :created_at ]
  end
end
