class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render status: 200, json: {
      message: "Successfully created user."
      }.to_json
    else
      render json: {errors: user.errors}, status: 422
    end
  end


  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end