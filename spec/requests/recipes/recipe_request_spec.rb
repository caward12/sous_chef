require 'rails_helper'

describe "recipes api" do
  it "can return all recipes for given user" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    recipe.ingredients.create(name: "flour", amount: "1 cup")
    recipe.ingredients.create(name: "eggs", amount: "2")
    recipe.categories.create(name: "breakfast")
    recipe2 = user.recipes.create(name: "pbj", servings: 1, prep_time: "5 min", instructions: "spread peanut butter one one slice of bread and jam on the other and place on top of each other")
    recipe2.ingredients.create(name: "peanut butter", amount: "2tb")
    recipe2.ingredients.create(name: "bread", amount: "2 slices")
    recipe2.ingredients.create(name: "jam", amount: "1tb")
    recipe2.categories.create(name: "lunch")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    get "/api/v1/recipes?user_id=#{user.id}"

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
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    recipe.ingredients.create(name: "flour", amount: "1 cup")
    recipe.ingredients.create(name: "eggs", amount: "2")
    recipe.categories.create(name: "breakfast")

    get "/api/v1/recipes/#{recipe.id}"

    expect(response).to be_success

    parsed_recipe = JSON.parse(response.body)

    expect(parsed_recipe["name"]).to eq("pancakes")
    expect(parsed_recipe["cook_time"]).to eq("30 min")
    expect(parsed_recipe["ingredients"].count).to eq(2)
    expect(parsed_recipe["instructions"]).to eq("mix all and pour on hot griddle")
    expect(parsed_recipe["categories"].first["name"]).to eq("breakfast")
  end

  it "can update a recipe" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix and pour on hot griddle")
    recipe.ingredients.create(name: "flour", amount: "1 cup")
    recipe.ingredients.create(name: "eggs", amount: "2")
    recipe.categories.create(name: "breakfast")
    params ={
      recipe: {
        name: "banana pancakes"
      }
    }
    put "/api/v1/recipes/#{recipe.id}", params

    expect(response).to be_success

    updated_recipe = JSON.parse(response.body)

    expect(updated_recipe["name"]).to eq("banana pancakes")
  end

  it "can create a new recipe with name, servings, cook_time, prep_time, instructions and user" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    params ={ recipe: {
      name: "butter toast",
      servings: 1,
      cook_time: "5 min",
      instructions: "toast bread and slather in butter",
      user_id: "#{user.id}"
      }
    }

    post "/api/v1/recipes", params

    expect(response).to be_success

    new_recipe = JSON.parse(response.body)
    expect(new_recipe["name"]).to eq("butter toast")
    expect(new_recipe["servings"]).to eq(1)
    expect(new_recipe["cook_time"]).to eq("5 min")
    expect(new_recipe["instructions"]).to eq("toast bread and slather in butter")

  end
end