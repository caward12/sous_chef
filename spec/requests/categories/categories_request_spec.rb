require 'rails_helper'

describe "categories api" do
  it "can return all categories created by given user" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    recipe.ingredients.create(name: "flour", amount: "1 cup")
    recipe.ingredients.create(name: "eggs", amount: "2")
    recipe.categories.create(name: "breakfast")
    recipe.categories.create(name: "light")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    get "/api/v1/categories"

    expect(response).to be_success

    categories = JSON.parse(response.body)

    expect(categories.count).to eq(2)
    expect(categories.last["name"]).to eq("light")
    expect(categories.first["name"]).to eq("breakfast")
  end

  it "can create a category for given recipe" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")

    params= {
      recipe_id: recipe.id,
      categories: {
        "0"=> {name: "breakfast"}}
    }
    post "/api/v1/categories", params

    expect(response).to be_success

    new_category = JSON.parse(response.body)
    expect(new_category.first["name"]).to eq("breakfast")
  end

  it "can update a category name" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    category = recipe.categories.create(name: "breafast")

    put "/api/v1/categories/#{category.id}?name=breakfast"

    expect(response).to be_success

    updated_category = JSON.parse(response.body)

    expect(updated_category["name"]).to eq("breakfast")
  end
end