require 'rails_helper'

describe "recipe categories api" do
  it "can delete a category from a recipe" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    recipe.categories.create(name: "breakfast")
    recipe.categories.create(name: "lunch")

    recipe_category = recipe.recipe_categories.last

    delete "/api/v1/recipe_categories/#{recipe_category.id}"

    expect(response).to be_success

    expect(recipe.categories.count).to eq(1)  
  end
end