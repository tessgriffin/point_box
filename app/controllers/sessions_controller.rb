class SessionsController < ApplicationController
  skip_before_action :ensure_signed_in, only: [:new, :create]

  def create
    if user = User.authenticate(user_params)
      sign_in(user)
      redirect_to root_path
    else
      flash.now[:error] = "Incorrect email or password"
      render :new
    end
  end

  def destroy
    session.delete(:current_user_id)
    redirect_to sign_in_path, notice: "Signed out successfully"
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end