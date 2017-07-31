require 'rails_helper'

describe "edit recipe", :js => :true do
  it "user can edit recipe " do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    recipe.ingredients.create(name: "flour", amount: "2 cup")

    login_user(user)

    visit recipe_path(recipe)

    click_on "Edit Recipe"

    fill_in "recipe-name", with: "fluffy pancakes"
    fill_in "ingredient-amount", with: "2 cups"
    click_on "Submit"

    expect(page).to have_content "fluffy pancakes"
    expect(page).to have_content "2 cups"
  end
end