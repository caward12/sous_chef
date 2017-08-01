class GroceryListsController < ApplicationController

  def index
    @grocery_lists = GroceryList.where(user_id: current_user.id)
  end

  def new
  end

  def show
    @grocery_list = GroceryList.find(params[:id])
  end

end