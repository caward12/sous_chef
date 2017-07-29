require 'rails_helper'

describe "create new recipe", :js => :true do
  it "user can create new recipe via form" do
    user = User.create(first_name: "Bob", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test")
    login_user(user)

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