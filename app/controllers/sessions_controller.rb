class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    session[:current_user_email] = params[:user][:email]
    redirect_to root_path
  end

  def destroy
    session.delete(:current_user_email)
    redirect_to root_path, notice: "Signed out successfully"
  end
end