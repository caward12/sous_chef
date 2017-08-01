require 'rails_helper'

describe "grocery list api" do
  it "can create a grocery list from recipe ids" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    recipe.ingredients.create(name: "flour", amount: "1 cup")
    recipe.ingredients.create(name: "eggs", amount: "2")
    recipe2 = user.recipes.create(name: "pbj", servings: 1, prep_time: "5 min", instructions: "spread peanut butter one one slice of bread and jam on the other and place on top of each other")
    recipe2.ingredients.create(name: "peanut butter", amount: "2tb")
    recipe2.ingredients.create(name: "bread", amount: "2 slices")
    recipe2.ingredients.create(name: "jam", amount: "1tb")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    params = {
      recipes: [recipe.id, recipe2.id]
    }

    post "/api/v1/grocery_lists", params

    expect(response).to be_success

    parsed_grocery_list = JSON.parse(response.body)

    expect(parsed_grocery_list).to be_a(Hash)
    expect(parsed_grocery_list["grocery_list_items"]).to be_an(Array)
    expect(parsed_grocery_list["grocery_list_items"].first["item"]).to eq("flour")
    expect(parsed_grocery_list["grocery_list_items"].last["item"]).to eq("jam")
  end
end
