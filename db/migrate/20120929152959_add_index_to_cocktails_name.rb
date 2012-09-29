class AddIndexToCocktailsName < ActiveRecord::Migration
  def change
  	add_index :cocktails, :name, unique: true
  end
end
