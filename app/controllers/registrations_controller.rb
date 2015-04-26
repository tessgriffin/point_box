class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    session[:current_user_email] = params[:user][:email]
    redirect_to root_path
  end
end