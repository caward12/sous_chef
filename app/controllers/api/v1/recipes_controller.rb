class Api::V1::RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Recipe.where('user_id= ?', params[:user_id])
  end

  def show
    render json: Recipe.find(params[:id])
  end

end