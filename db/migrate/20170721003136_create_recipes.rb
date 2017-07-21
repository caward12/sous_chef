class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :cook_time
      t.string :prep_time
      t.integer :servings
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
