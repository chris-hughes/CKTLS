class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.integer :cocktail_id
      t.text :direction

      t.timestamps
    end
  end
end
