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

  scenario "admin can update a reward" do 
    admin_user = User.create!(email: "admin@our_app.com", password: "secret", admin: true)
    Reward.create!(name: "old", description: "old")

    sign_in_as(admin_user)
    visit rewards_path

    click_on "Update reward"
    within("form") do
      fill_in "Name", with: "chocolate"
      fill_in "Description", with: "yummy"
    end
    click_on "Submit"

    visit rewards_path
    expect(page).to have_content("chocolate")
    expect(page).not_to have_content("old")
  end

  scenario "admin can delete a reward" do 
    admin_user = User.create!(email: "admin@our_app.com", password: "secret", admin: true)
    Reward.create!(name: "stuff", description: "super special description")

    sign_in_as(admin_user)
    visit rewards_path

    click_on "Delete reward"

    expect(page).not_to have_content("stuff")
    expect(page).not_to have_content("super special description")
  end

  scenario "user cannot create rewards" do 
    non_admin = User.create!(email: "stuff", password: "password", admin: false)

    sign_in_as(non_admin)
    expect {
      visit new_reward_path(non_admin)
    }.to raise_error(ActionController::RoutingError)

  end
end