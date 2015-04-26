require 'rails_helper'

feature "User signs up" do
  scenario "successfully" do
    visit root_path
    click_on "Sign Up"
    fill_out_auth_form
    submit_sign_up

    expect(page).to show_that_user_is_signed_in
  end

  scenario "remains signed in after visiting another page" do
    sign_up_new_user

    visit root_path

    expect(page).to show_that_user_is_signed_in
  end

  scenario "can sign out" do
    sign_up_new_user

    click_on "Sign Out"

    expect(page).to have_content("Signed out successfully")
    expect(page).to show_that_user_is_signed_out
  end

  scenario "sees their email when signed in" do
    sign_up_new_user(email: "user@example.com")

    expect(page).to have_content("user@example.com")

    click_on "Sign Out"
    sign_up_new_user(email: "user2@example.com")

    expect(page).to have_content("user2@example.com")
  end

  scenario "can sign in after signing up" do
    sign_up_new_user

    click_on "Sign Out"
    click_link "Sign In"

    fill_out_auth_form
    submit_sign_in

    expect(page).to show_that_user_is_signed_in
  end

  scenario "must have unique email" do
    User.create!(email: "user@example.com", password: "omglol")
    sign_up_new_user(email: "user@example.com", password: "different")

    expect(page).to show_that_user_is_signed_out
    expect(page).to have_content("already been taken")
  end

  scenario "must sign in with correct password" do 
    sign_up_new_user(email: "user@example.com", password: "test")

    click_on "Sign Out"
    visit sign_in_path

    fill_out_auth_form(email: "user@example.com", password: "not")
    submit_sign_in

    expect(page).to show_that_user_is_signed_out
    expect(page).to have_content("Incorrect email or password")
  end

  private

  def sign_up_new_user(**kwargs)
    visit sign_up_path
    fill_out_auth_form(**kwargs)
    submit_sign_up
  end

  def show_that_user_is_signed_in
    have_content("Sign Out").and \
      have_no_content("Sign In").and \
      have_no_content("Sign Up")
  end

  def show_that_user_is_signed_out
    have_no_content("Sign Out").and \
      have_content("Sign In").and \
      have_content("Sign Up")
  end
end