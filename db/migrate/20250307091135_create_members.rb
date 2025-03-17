class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, null: true
      t.references :server, type: :uuid, foreign_key: true, null: false
      t.string :membership, null: false, default: "user"
      t.string :first_name
      t.string :last_name
      t.string :username
      t.integer :age

      t.timestamps
    end
  end
end
