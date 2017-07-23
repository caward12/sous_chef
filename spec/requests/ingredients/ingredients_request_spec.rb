require 'rails_helper'

describe "ingredients api" do
  it "can create ingredients for a recipe" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    params = {recipe_id: 1,
              ingredients: [
              {name: "flour", amount:"2 cups"},
              {name: "eggs", amount: "2"}
              ]}

    post "/api/v1/ingredients", params

    expect(response).to be_success

    ingredients = JSON.parse(response.body)

    expect(ingredients.count).to eq(2)
    expect(ingredients.first["name"]).to eq("flour")
    expect(ingredients.first["amount"]).to eq("2 cups")
    expect(ingredients[1]["name"]).to eq("eggs")
    expect(ingredients[1]["amount"]).to eq("2")
  end
end