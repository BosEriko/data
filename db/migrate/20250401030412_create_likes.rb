class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes, id: :uuid do |t|
      t.references :likeable, polymorphic: true, null: false, type: :uuid
      t.references :member, null: false, foreign_key: true, type: :uuid
      t.references :server, type: :uuid, foreign_key: true, null: false
      
      t.timestamps
    end
  end
end