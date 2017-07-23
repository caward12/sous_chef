class Api::V1::RecipeCategoriesController < ApplicationController

  def destroy
    recipe_category = RecipeCategory.find(params[:id])
    recipe_category.destroy
    render status: 200, json: {
      message: "successfully deleted recipe category"
    }.to_json
  end

end