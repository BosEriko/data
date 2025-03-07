class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true, null: false
      t.references :server, type: :uuid, foreign_key: true, null: false
      t.integer :membership_type, null: false, default: 0
      t.string :first_name
      t.string :last_name
      t.string :username
      t.integer :age

      t.timestamps
    end
  end
end
