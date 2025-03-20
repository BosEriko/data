class CreateServers < ActiveRecord::Migration[8.0]
  def change
    create_table :servers, id: :uuid do |t|
      t.string :public_key, null: false
      t.string :private_key, null: false
      t.string :identifier, null: false
      t.text :domains, array: true, default: []
      t.text :features, array: true, default: []
      t.uuid :creator_id, null: false

      t.timestamps
    end

    add_index :servers, :public_key, unique: true
    add_index :servers, :private_key, unique: true
    add_index :servers, :identifier, unique: true
    add_index :servers, :creator_id
    add_foreign_key :servers, :users, column: :creator_id
  end
end
