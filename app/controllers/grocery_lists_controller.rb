class GroceryListsController < ApplicationController

  def show
    @grocery_list = GroceryList.find(params[:id])
  end
  
end