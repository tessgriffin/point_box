class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :signed_in?, :current_user
  before_action :ensure_signed_in

  def signed_in?
    session[:current_user_id].present?
  end

  def current_user
    if signed_in?
      @current_user ||= User.find_by(id: session[:current_user_id])
    end
  end

  private

  def sign_in(user)
    session[:current_user_id] = user.id
  end

  def ensure_signed_in
    unless signed_in?
      redirect_to sign_in_path, notice: "You must be signed in to view this page"
    end
  end
end
