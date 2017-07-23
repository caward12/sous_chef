class Api::V1::IngredientsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    recipe = Recipe.find(params[:recipe_id])
    params["ingredients"].each do |ingredient|
      if ingredient["name"] != "" && ingredient["amount"] != ""
        recipe.ingredients.create(ingredient_params(ingredient))
      else
        render json: ingredient.errors.full_messages
      end
    end
    render json: recipe.ingredients
  end

  private
  def ingredient_params(incoming_params)
    incoming_params.permit(:name, :amount)
  end

end