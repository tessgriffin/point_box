class RedemptionsController < ApplicationController
  def create
    reward = Reward.find(params[:reward_id])
    point = current_user.unredeemed_points.first!
    point.redeemed_reward = reward
    point.save!
    redirect_to dashboard_path
  end
end