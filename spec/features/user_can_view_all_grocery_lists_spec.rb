require 'rails_helper'

describe "all grocery lists" do
  it "user can view all grocery lists" do
    user = User.create(first_name: "Sue", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    recipe.ingredients.create(name: "flour", amount: "2 cups")
    recipe.ingredients.create(name: "egg", amount: "1")
    gl = user.grocery_lists.create()

    gl.grocery_list_items.create(item: "flour")
    gl.grocery_list_items.create(item: "egg")

    login_user(user)

    visit grocery_lists_path

    expect(page).to have_content("All Grocery Lists")

  end
end