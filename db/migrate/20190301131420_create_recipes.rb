class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :preparation_time
      t.integer :efficiency
      t.text :preparation_method
      t.text :tags
      t.text :ingredients

      t.timestamps
    end
  end
end
