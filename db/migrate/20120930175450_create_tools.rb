class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.integer :cocktail_id
      t.string :tool

      t.timestamps
    end
  end
end
