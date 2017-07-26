require 'rails_helper'

describe "user dashboard" do
  it "can display 4 random recipes and recipe buttons" do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    user.recipes.create(name: "BLT", servings: 1, cook_time: "20 min", prep_time: "5 min", instructions: "cook bacon and assemble sandwich")
    user.recipes.create(name: "pbj", servings: 1, prep_time: "5 min", instructions: "spread pb on one slice bread, spead jam on other piece and put together")
    user.recipes.create(name: "lasagna", servings: 6, cook_time: "1 hour", prep_time: "15 minutes", instructions: "do the things")

    login_user(user)

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("pancakes")
    expect(page).to have_content("BLT")
    expect(page).to have_content("pbj")
    expect(page).to have_content("lasagna")
    expect(page).to have_button("See All Recipes")
    expect(page).to have_button("Create New Recipe")
  end
end