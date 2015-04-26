class RewardsController < ApplicationController
  before_action :ensure_admin_user, except: :index
  def index
    @rewards = Reward.all
  end

  def new
    @reward = Reward.new
  end

  def create
    @reward = Reward.new(reward_params)
    if @reward.save
      redirect_to rewards_path
    else
      render :new
    end
  end

  def edit
    @reward = Reward.find(params[:id])
  end

  def update
    @reward = Reward.find(params[:id])
    if @reward.update(reward_params)
      redirect_to rewards_path
    else
      render :edit
    end
  end

  def destroy
    @reward = Reward.find(params[:id])
    @reward.destroy
    redirect_to rewards_path
  end
  private

  def reward_params
    params.require(:reward).permit(:name, :description)
  end

  def ensure_admin_user
    unless current_user.admin?
      raise ActionController::RoutingError.new("Not found")
    end
  end
end