class ChangeRedeemedToRedeemedReward < ActiveRecord::Migration
  def up
    add_column :points, :redeemed_reward_id, :integer
    remove_column :points, :redeemed
  end

  def down
    add_column :points, :redeemed, :boolean, null: false, default: false
    remove_column :points, :redeemed_reward_id
  end
end
