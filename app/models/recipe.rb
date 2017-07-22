class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  # accepts_nested_attributes_for :ingredients, allow_destroy: true
  # accepts_nested_attributes_for :instructions, allow_destroy: true
  # accepts_nested_attributes_for :categories, allow_destroy: true
end
