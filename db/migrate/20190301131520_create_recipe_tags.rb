class CreateRecipeTags < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_tags do |t|
      t.references :recipe, foreign_key: true
      t.string :tag

      t.timestamps
    end
  end
end
