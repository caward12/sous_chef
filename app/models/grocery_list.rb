class GroceryList < ApplicationRecord
  has_many :grocery_list_items
  belongs_to :user

end