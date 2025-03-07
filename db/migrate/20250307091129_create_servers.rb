class CreateServers < ActiveRecord::Migration[8.0]
  def change
    create_table :servers, id: :uuid do |t|
      t.string :public_key, null: false
      t.string :private_key, null: false
      t.string :identifier, null: false
      t.text :domains, array: true, default: []
      t.text :features, array: true, default: []

      t.timestamps
    end

    add_index :servers, :public_key, unique: true
    add_index :servers, :private_key, unique: true
    add_index :servers, :identifier, unique: true
  end
end
