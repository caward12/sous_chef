require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context "validations" do
    it {should validate_presence_of(:name)}
  end

  context "associations" do
    it {should belong_to :user}
    it {should have_many :ingredients}
    it {should have_many :recipe_categories}
    it {should have_many :categories}
  end
end
