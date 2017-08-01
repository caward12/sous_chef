# require 'rails_helper'
#
# describe "create grocery list", :js => :true do
#   it "can create grocery list from recipes" do
#     driver = Selenium::WebDriver.for :firefox
#
#     user = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234", password_confirmation: "1234")
#     recipe = user.recipes.create(name: "pancakes", servings: 2, cook_time: "30 min", prep_time: "5 min", instructions: "mix all and pour on hot griddle")
#     recipe.ingredients.create(name: "flour", amount: "2 cups")
#     recipe.ingredients.create(name: "eggs", amount: "2")
#     recipe.ingredients.create(name: "milk", amount: "1 cup")
#     recipe2 = user.recipes.create(name: "blt", servings: 2, cook_time: "20 min", prep_time: "5 min", instructions: "cook bacon, toast the bread and build the sandwich")
#     recipe2.ingredients.create(name: "bread", amount: "4 slices")
#     recipe2.ingredients.create(name: "tomatoes", amount: "1 whole, sliced")
#     recipe2.ingredients.create(name: "bacon", amount: "4 slices")
#     recipe2.ingredients.create(name: "mayo", amount: "2 tb")
#     login_user(user)
#
#     visit new_grocery_list_path
#
#     click_on driver.find_elements(:xpath, "//input[@id='#{recipe.id}']")
#     click_on driver.find_elements(:xpath, "//input[@id='#{recipe2.id}']")
#
#
#     click_on "Create New Grocery List"
#
#     expect(current_path).to eq(grocery_list_path(GroceryList.last))
#
#     expect(page).to have_content("flour")
#     expect(page).to have_content("eggs")
#     expect(page).to have_content("milk")
#     expect(page).to have_content("bread")
#     expect(page).to have_content("tomatoes")
#     expect(page).to have_content("bacon")
#     expect(page).to have_content("mayo")
#   end
# end