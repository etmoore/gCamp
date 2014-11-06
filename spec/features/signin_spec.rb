require 'rails_helper'

feature "Sign In" do
  scenario "User signs in with valid information" do
    User.create first_name: "Testy", last_name: "McTest", email: "test@test.com",
                password: "test", password_confirmation: "test"
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "test"
    within ".actions" do
      click_on "Sign In"
    end
    expect(page).to have_content "Testy McTest"
    expect(page).to have_content "Sign Out"
  end

  scenario "User signs in with invalid email" do
    User.create first_name: "Testy", last_name: "McTest", email: "test@test.com",
                password: "test", password_confirmation: "test"
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "collin@example.com"
    fill_in "Password", with: "test"
    within ".actions" do
      click_on "Sign In"
    end
    expect(page).to have_content "Username/password combination is invalid."
  end

  scenario "User signs in with invalid password" do
    User.create first_name: "Testy", last_name: "McTest", email: "test@test.com",
                password: "test", password_confirmation: "test"
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "testy"
    within ".actions" do
      click_on "Sign In"
    end
    expect(page).to have_content "Username/password combination is invalid."
  end
end
