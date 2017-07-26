class Api::V1::RecipeCategoriesController < ApplicationController

  def create
    params["categories"].each do |category|
      RecipeCategory.create(recipe_id: params["recipe_id"], category_id: category)
    end
  end

  def destroy
    recipe_category = RecipeCategory.find(params[:id])
    recipe_category.destroy
    render status: 200, json: {
      message: "successfully deleted recipe category"
    }.to_json
  end

end