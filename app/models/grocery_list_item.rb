class GroceryListItem < ApplicationRecord
  belongs_to :grocery_list
  validates :item, presence: true
end