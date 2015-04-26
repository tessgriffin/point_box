class DashboardsController < ApplicationController
  def show
    @users = User.where(admin: false)
  end
end