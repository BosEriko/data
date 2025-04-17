class CreateBlogs < ActiveRecord::Migration[8.0]
  def change
    create_table :blogs, id: :uuid do |t|
      t.references :server, type: :uuid, foreign_key: true, null: false
      t.references :member, type: :uuid, foreign_key: true, null: false
      t.integer :comments_count, default: 0, null: false
      t.integer :likes_count, default: 0, null: false
      t.string :title

      t.timestamps
    end
  end
end
