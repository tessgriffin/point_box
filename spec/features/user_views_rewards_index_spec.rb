require 'rails_helper'

feature 'User views rewards index' do 
  include AuthHelpers

  scenario "sees all rewards" do 
    Reward.create!(name: "Dog Bone", description: "tasty")
    john = User.create!(email: "john@whatever.com", password: "password")

    sign_in_as(john)
    visit rewards_path

    expect(page).to have_content("Dog Bone")
    expect(page).to have_content("tasty")
  end

  scenario "user redeems a point" do 
    Reward.create!(name: "Dog Bone", description: "tasty")
    john = User.create!(email: "john@whatever.com", password: "password")
    john.unredeemed_points.create!

    sign_in_as(john)
    visit rewards_path

    click_on "Redeem point"

    visit dashboard_path
    expect(page).to have_content("Dog Bone")
  end

  scenario "admin can create a reward" do 
    admin_user = User.create!(email: "admin@our_app.com", password: "secret", admin: true)
    
    sign_in_as(admin_user)
    visit rewards_path

    click_on "Create reward"
    within("form") do
      fill_in "Name", with: "chocolate"
      fill_in "Description", with: "yummy"
    end
    click_on "Submit"

    visit rewards_path
    expect(page).to have_content("chocolate")
  end
end