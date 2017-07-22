class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "Successfully signed in!"
      redirect_to user_path(@user)
    else
      flash[:notice] = "Unsuccessful sign in attempt"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end