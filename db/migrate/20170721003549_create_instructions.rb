class CreateInstructions < ActiveRecord::Migration[5.0]
  def change
    create_table :instructions do |t|
      t.text :steps
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
