require 'rails_helper'

describe "create grocery list" do
  it "can create grocery list from a recipe" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    recipe.ingredients.create(name: "flour", amount: "2 cups")
    recipe.ingredients.create(name: "eggs", amount: "2")
    recipe.ingredients.create(name: "milk", amount: "1 cup")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit recipe_path(recipe)

    click_on "Create Grocery List"


    expect(current_path).to eq(grocery_list_path(GroceryList.last))
    expect(page).to have_content("flour")
    expect(page).to have_content("eggs")
    expect(page).to have_content("milk")
  end
end