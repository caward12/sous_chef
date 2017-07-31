require 'rails_helper'

describe "recipe index", :js => :true do
  it "can sort recipes by categories"  do
    user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
    user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
    user.recipes.first.categories.create(name: "breakfast")
    user.recipes.create(name: "BLT", servings: 1, cook_time: "20 min", prep_time: "5 min", instructions: "cook bacon and assemble sandwich")
    user.recipes.create(name: "pbj", servings: 1, prep_time: "5 min", instructions: "spread pb on one slice bread, spead jam on other piece and put together")
    user.recipes.create(name: "lasagna", servings: 6, cook_time: "1 hour", prep_time: "15 minutes", instructions: "do the things")
    user.recipes.last.categories.create(name: "dinner")

    login_user(user)

    visit recipes_path

    within ".col.s3.recipe-categories" do
      expect(page).to have_content("breakfast")
      expect(page).to have_content("dinner")
    end
    click_on "breakfast"


    within ".all-recipes" do
      expect(page).to have_content("pancakes")
      expect(page).to_not have_content("lasagna")
      expect(page).to_not have_content("BLT")
      expect(page).to_not have_content("pbj")
    end
  end
end