class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.references :commentable, polymorphic: true, null: false, type: :uuid
      t.references :member, null: false, foreign_key: true, type: :uuid
      t.references :server, type: :uuid, foreign_key: true, null: false
      t.integer :likes_count, default: 0, null: false
      
      t.timestamps
    end
  end
end