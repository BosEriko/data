class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.references :server, type: :uuid, foreign_key: true, null: false
      t.references :member, type: :uuid, foreign_key: true, null: false
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
