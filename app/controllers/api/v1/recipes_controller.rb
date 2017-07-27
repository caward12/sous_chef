class Api::V1::RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Recipe.where('user_id= ?', current_user.id)
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

  def create
    user = current_user
    @recipe = user.recipes.new(recipe_params)
    if @recipe.save
      render json: @recipe
    else
      render json: @recipe.errors.full_messages
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name,
                  :servings,
                  :cook_time,
                  :prep_time,
                  :user_id,
                  :instructions
                  )
  end

end