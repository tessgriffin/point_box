class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :redeemed_reward, class_name: "Reward"

  def self.unredeemed
    where(redeemed_reward: nil)
  end

  def redeemed?
    redeemed_reward.nil?
  end
end