class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories

  validates :name, presence: true
end
