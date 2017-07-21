class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients
  has_many :instructions
  has_many :categories, through: :recipe_categories
end
