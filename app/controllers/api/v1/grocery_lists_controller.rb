class Api::V1::GroceryListsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = current_user
    grocery_list = user.grocery_lists.create()
    params["recipes"].each do |recipe_id|
      recipe = Recipe.find(recipe_id)
      recipe.ingredients.each do |ingredient|
        grocery_list.grocery_list_items.create(item: ingredient.name)
      end
    end
    render json: grocery_list
  end

end