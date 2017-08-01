require 'rails_helper'

describe "grocery list" do
  it "user can view single grocery list" do
    user = User.create(first_name: "Sue", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    recipe.ingredients.create(name: "flour", amount: "2 cups")
    recipe.ingredients.create(name: "egg", amount: "1")
    gl = user.grocery_lists.create()

    gl.grocery_list_items.create(item: "flour")
    gl.grocery_list_items.create(item: "egg")

    login_user(user)

    visit grocery_list_path(gl)

    expect(page).to have_content("flour")
    expect(page).to have_content("egg")
  end
end