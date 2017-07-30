class Api::V1::IngredientsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    recipe = Recipe.find(params[:recipe_id])
    params["ingredients"].each do |ingredient|
      if params["ingredients"][ingredient]["name"] != "" && params["ingredients"][ingredient]["amount"] != ""
        recipe.ingredients.create(ingredients_params(params["ingredients"][ingredient]))
      else
        render json: ingredient.errors.full_messages
      end
    end
    render json: recipe.ingredients
  end

  def update
    ingredient = Ingredient.find(params[:id])
    if ingredient.update_attributes(ingredient_params)
      render json: ingredient
    else
      render json: ingredient.error.full_messages
    end
  end

  private
  def ingredients_params(incoming_params)
    incoming_params.permit(:name, :amount)
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :amount, :id)
  end

end