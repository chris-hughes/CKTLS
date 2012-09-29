class CreateCocktails < ActiveRecord::Migration
  def change
    create_table :cocktails do |t|
    	t.string 	:name
    	t.string 	:family
    	t.integer 	:makes
    	t.string 	:glass
    	t.boolean	:chilled, default: false

      t.timestamps
    end
  end
end
