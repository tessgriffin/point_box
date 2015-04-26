class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :signed_in?, :current_user

  def signed_in?
    session[:current_user_email].present?
  end

  def current_user
    if signed_in?
      User.new(email: session[:current_user_email])
    end
  end
end
