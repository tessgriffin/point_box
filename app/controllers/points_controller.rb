class PointsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :ensure_admin_user

  def index
    @user = user
  end

  def create
    user.points.create!
    redirect_to dashboard_path, notice: point_added_notice
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def point_added_notice
    "1 point assigned to #{user.email}, they now have #{pluralize(user.unredeemed_points_count, "points")}"
  end

  def ensure_admin_user
    unless current_user.admin?
      raise ActionController::RoutingError.new("Not found")
    end
  end
end