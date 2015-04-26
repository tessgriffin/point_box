module AuthHelpers
  def sign_in_as(user)
    visit sign_in_path
    fill_out_auth_form(email: user.email, password: user.password)
    submit_sign_in
  end

  def sign_out
    click_on "Sign Out"
  end

  def fill_out_auth_form(email: "user@example.com", password: "password")
    within("form") do
      fill_in "Email", with: email
      fill_in "Password", with: password
    end
  end

  def submit_sign_up
    within("form") do
      click_on "Sign Up"
    end
  end

  def submit_sign_in
    within("form") do
      click_on "Sign In"
    end
  end
end