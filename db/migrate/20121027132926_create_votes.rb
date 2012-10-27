class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :cocktail_id

      t.timestamps
    end

    add_index :votes, :user_id
    add_index :votes, :cocktail_id
    add_index :votes, [:user_id, :cocktail_id], unique: true
  end
end

