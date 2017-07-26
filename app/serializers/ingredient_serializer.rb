class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :recipe_id
end
