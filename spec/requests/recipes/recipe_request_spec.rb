require 'rails_helper'

describe "recipes api" do
  it "can return all recipes for given user" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min")
    recipe.ingredients.create(name: "flour", amount: "1 cup")
    recipe.ingredients.create(name: "eggs", amount: "2")
    recipe.instructions.create(steps: "mix all and pour on hot griddle")
    recipe.categories.create(name: "breakfast")
    recipe2 = user.recipes.create(name: "pbj", servings: 1, prep_time: "5 min")
    recipe2.ingredients.create(name: "peanut butter", amount: "2tb")
    recipe2.ingredients.create(name: "bread", amount: "2 slices")
    recipe2.ingredients.create(name: "jam", amount: "1tb")
    recipe2.instructions.create(steps: "spread peanut butter one one slice of bread and jam on the other and place on top of each other")
    recipe2.categories.create(name: "lunch")

    get "/api/v1/recipes?user_id=1"

    expect(response).to be_success

    recipes = JSON.parse(response.body)

    expect(recipes.count).to eq(2)
    expect(recipes.first["name"]).to eq("pancakes")
    expect(recipes.first["ingredients"].count).to eq(2)
    expect(recipes.first["categories"].first["name"]).to eq("breakfast")
    expect(recipes.last["name"]).to eq("pbj")
    expect(recipes.last["ingredients"].count).to eq(3)
    expect(recipes.last["categories"].first["name"]).to eq("lunch")
  end

  it "can return one recipe given the id" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min")
    recipe.ingredients.create(name: "flour", amount: "1 cup")
    recipe.ingredients.create(name: "eggs", amount: "2")
    recipe.instructions.create(steps: "mix all and pour on hot griddle")
    recipe.categories.create(name: "breakfast")

    get "/api/v1/recipes/#{recipe.id}"

    expect(response).to be_success

    parsed_recipe = JSON.parse(response.body)

    expect(parsed_recipe["name"]).to eq("pancakes")
    expect(parsed_recipe["cook_time"]).to eq("30 min")
    expect(parsed_recipe["ingredients"].count).to eq(2)
    expect(parsed_recipe["instructions"].first["steps"]).to eq("mix all and pour on hot griddle")
    expect(parsed_recipe["categories"].first["name"]).to eq("breakfast")
  end

  it "can update a recipe" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min")
    recipe.ingredients.create(name: "flour", amount: "1 cup")
    recipe.ingredients.create(name: "eggs", amount: "2")
    recipe.instructions.create(steps: "mix all and pour on hot griddle")
    recipe.categories.create(name: "breakfast")

    put "/api/v1/recipes/#{recipe.id}?name=banana pancakes"

    expect(response).to be_success

    updated_recipe = JSON.parse(response.body)

    expect(updated_recipe["name"]).to eq("banana pancakes")
  end

  it "can create a new recipe" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")

    
  end
end