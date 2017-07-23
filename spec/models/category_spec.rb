require 'rails_helper'

RSpec.describe Category, type: :model do
  context "validations" do
    it {should validate_presence_of(:name)}
  end

  context "associations" do
    it {should have_many :recipe_categories}
    it {should have_many :recipes}
  end
end
