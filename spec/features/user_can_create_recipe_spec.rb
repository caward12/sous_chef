require 'rails_helper'

describe "create new recipe", :type => :feature, :js => true do
  xit "user can create new recipe via form" do
    visit root_path

    click_on "Create Account"

    fill_in "user[first_name]", with: "Bob"
    fill_in "user[last_name]", with: "Jones"
    fill_in "user[email]", with: "bob@aol.com"
    fill_in "user[password]", with: "1234"
    fill_in "user[password_confirmation]", with: "1234"
    click_on "Create Account"

    click_on "Create New Recipe"

    expect(current_path).to eq(new_recipe_path)

    fill_in "recipe[name]", with: "Avocado Toast"
    fill_in "recipe[servings]", with: "2"
    fill_in "recipe[cook_time]", with: "2 min"
    fill_in "recipe[prep_time]", with: "5 min"
    click_on "Add Ingredients"

    expect(current_path).to eq(new_recipe_path)

  end
end