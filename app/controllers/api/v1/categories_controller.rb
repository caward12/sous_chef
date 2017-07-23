class Api::V1::CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    user = User.find(params[:user_id])
    render json: Category.joins(:recipe_categories, :recipes).where('recipes.user_id = ?', user.id)
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    render json: recipe.categories.create(category_params)
  end

  def update
    category = Category.find(params[:id])
    if category.update_attributes(category_params)
      render json: category
    else
      render json: category.errors.full_messages
    end
  end

  private
  def category_params
    params.permit(:name)
  end
end