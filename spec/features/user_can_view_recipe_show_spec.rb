require 'rails_helper'

describe "recipe show", :js => :true do
  it "user can view recipe show page" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    recipe.ingredients.create(name: "flour", amount: "2 cups")
    recipe.categories.create(name: "breakfast")

    login_user(user)

    visit recipe_path(recipe)

    expect(page).to have_content("pancakes")
    expect(page).to have_content("Servings: 2")
    expect(page).to have_content("Prep Time: 5 min")
    expect(page).to have_content("Cook Time: 30 min")
    expect(page).to have_content("2 cups")
    expect(page).to have_content("flour")
    expect(page).to have_content("mix all and pour on hot griddle")
    expect(page).to have_content("breakfast")
  end
end