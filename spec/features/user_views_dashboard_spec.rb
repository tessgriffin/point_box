require 'rails_helper'

feature 'User views dashboard' do
  include AuthHelpers

  scenario 'sees number of points' do
    john = User.create!(email: "john@whatever.com", password: "password")
    jane = User.create!(email: "jane@whatever.com", password: "something")
    2.times { john.points.create! }
    jane.points.create!

    sign_in_as(john)
    visit dashboard_path

    expect(page).to have_content("You have 2 points")

    sign_out
    sign_in_as(jane)

    expect(page).to have_content("You have 1 point")
  end

  scenario 'admins can assign points to a user' do
    admin_user = User.create!(email: "admin@our_app.com", password: "secret", admin: true)
    jane = User.create!(email: "jane@whatever.com", password: "i like cats")

    sign_in_as(admin_user)
    visit dashboard_path
    add_point_to(jane)

    expect(page).to have_content("1 point assigned to jane@whatever.com, they now have 1 point")

    add_point_to(jane)

    expect(page).to have_content("1 point assigned to jane@whatever.com, they now have 2 points")

    sign_out
    sign_in_as(jane)
    visit dashboard_path

    expect(page).to have_content("You have 2 points")
  end

  scenario "admin users do not have a points count" do
    admin_user = User.create!(email: "admin@our_app.com", password: "secret", admin: true)

    sign_in_as(admin_user)
    visit dashboard_path

    expect(page).not_to have_content("You have 0 points")
    within(".user-points") do
      expect(page).not_to have_content("admin@our_app.com")
    end
  end

  scenario "non-admins cannot add points" do
    non_admin_user = User.create!(email: "blah", password: "anything", admin: false)

    sign_in_as(non_admin_user)
    visit dashboard_path

    expect(page).not_to have_css(".user-points")

    expect {
      visit user_points_path(non_admin_user)
    }.to raise_error(ActionController::RoutingError)
  end

  private

  def add_point_to(user)
    click_on user.email
    click_on "Add point"
  end
end