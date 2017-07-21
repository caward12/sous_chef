class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      binding.pry
      render json: @user
    else
      render json: {errors: @user.errors}, status: 422
    end
  end

  def destroy
    session.clear
    render status: 200
  end
end