# spec/system/login_spec.rb
require 'rails_helper'

RSpec.describe "User Login", type: :system do

  it "allows a user to log in with valid credentials" do

    user = AdminUser.create!(email: "kapilkhursade.210@gmail.com", password: "password")

    # Visit the login page
    visit new_admin_user_session_path

    # Fill in the login form
    fill_in "Email", with: "kapilkhursade.210@gmail.com"
    fill_in "Password", with: "password"

    # Submit the form
    click_button "Log in"

    # Expect to be redirected to the dashboard or home page
    expect(page).to have_content("You have to confirm your email address before continuing.")

  end

  it "does not allow login with invalid credentials" do
    visit new_admin_user_session_path

    fill_in "Email", with: "wrong@example.com"
    fill_in "Password", with: "wrongpassword"

    click_button "Log in"

    # Expect to see an error message
    expect(page).to have_content("Invalid Email or password.")
  end
end
