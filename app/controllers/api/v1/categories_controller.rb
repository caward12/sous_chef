class Api::V1::CategoriesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    user = User.find(current_user)
    render json: Category.joins(:recipe_categories, :recipes).where('recipes.user_id = ?', user.id).order(:id).uniq
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
      params["categories"].each do |category|
        if params["categories"][category]["name"] != ""
          recipe.categories.create(categories_params(params["categories"][category]))
        else
          render json: category.errors.full_messages
        end
    end
    render json: recipe.categories
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

  def categories_params(incoming_params)
    incoming_params.permit(:name)
  end

  def category_params
    params.permit(:name)
  end
end