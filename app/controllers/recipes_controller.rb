class RecipesController < ApplicationController

  def index
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @ingredient = Ingredient.new
  end
end