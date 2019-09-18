require "rails_helper"

RSpec.feature "Log in/out", type: :feature do
  scenario "Can Sign Up" do
    visit "/sign_up"
    fill_in "user_email", with: "test@test.com"
    fill_in "user_password", with: "password"
    click_button "Sign up"
    expect(page).to have_content('A helpful message to say you\'ve been signed in!')
  end

  scenario "can not sign up with invalid email", type: :feature do
    visit "/sign_up"
    fill_in "user_email", with: "test.com"
    click_button "Sign up"
    expect(page).not_to have_content('A helpful message to say you\'ve been signed in! Sign up Email Password Sign in')
  end

  scenario "Can Log In When Already Signed Up" do
    sign_in
    click_button "Sign out"
    user = sign_in
    expect(page).to have_content(user.email)
  end

  scenario "Can request password reset email" do
    visit "/passwords/new"
    fill_in "password_email", with: "test@test.com"
    click_button "Reset password"
    expect(page).to have_content("changing your password.")
  end

  scenario "Can Log Out when Logged In" do
    sign_in
    click_button "Sign out"
    expect(page).to have_button("Sign in")
  end

  scenario "User can add their username and see it once logged in" do
    visit "/sign_up"
    fill_in "user_email", with: "test@test.com"
    fill_in "user_password", with: "password"
    fill_in "user_username", with: "username"
    click_button "Sign up"
    expect(page).to have_content("username")
  end
end
