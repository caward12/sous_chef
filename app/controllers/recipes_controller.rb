class RecipesController < ApplicationController

  def index
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @ingredient = Ingredient.new
  end
end