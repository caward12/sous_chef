require 'date'
class CreateGroceryList < ActiveRecord::Migration[5.0]
  def change
    create_table :grocery_lists do |t|
      t.string :name, default: "#{(Date.today).strftime("%B")} #{Date.today.day} #{Date.today.year}"
      t.references :user, foreign_key: true
    end
  end
end
