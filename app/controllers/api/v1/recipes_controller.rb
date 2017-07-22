class Api::V1::RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Recipe.where('user_id= ?', params[:user_id])
  end

  def show
    render json: Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors.full_messages
    end
  end

  private

  def recipe_params
    params.permit(:name, :servings, :cook_time, :prep_time, :ingredients, :instructions, :categories)
  end

end