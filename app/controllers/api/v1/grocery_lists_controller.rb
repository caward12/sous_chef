class Api::V1::GroceryListsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = current_user
    recipe = Recipe.find(params["recipe_id"])
    grocery_list = user.grocery_lists.create()
    recipe.ingredients.each do |ingredient|
      grocery_list.grocery_list_items.create(item: ingredient.name)
    end
    render json: grocery_list
  end

end