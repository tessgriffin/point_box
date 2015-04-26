class Point < ActiveRecord::Base
  belongs_to :user

  def self.unredeemed
    where(redeemed: false)
  end
end