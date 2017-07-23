class RecipeSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :servings,
             :cook_time,
             :prep_time,
             :ingredients,
             :instructions,
             :categories
end
