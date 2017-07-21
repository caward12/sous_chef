class Category < ApplicationRecord
  has_many :recipes, through: :recipe_categories
end
