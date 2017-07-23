class Ingredient < ApplicationRecord
  belongs_to :recipe
  validates_presence_of :name, presence: true
  validates_presence_of :amount, presence: true
end
