class CreateGroceryListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :grocery_list_items do |t|
      t.string :item
      t.references :grocery_list, foreign_key: true
    end
  end
end
