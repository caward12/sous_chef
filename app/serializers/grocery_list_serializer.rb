class GroceryListSerializer < ActiveModel::Serializer
  attributes :id, :name, :grocery_list_items
end
