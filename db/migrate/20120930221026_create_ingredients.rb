class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.integer :cocktail_id
      t.string :ingredient
      t.integer :measure
      t.string :unit
      t.boolean :decoration, default: false

      t.timestamps
    end
  end
end
