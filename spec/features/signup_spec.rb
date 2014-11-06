require 'rails_helper'

feature "Signup" do
  scenario "User signs up" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Email", with: "jdoe@example.com"
    fill_in "Password", with: "john"
    fill_in "Password confirmation", with: "john"
    within ".actions" do
      click_on "Sign Up"
    end
    expect(page).to have_no_content "Sign Up"
    expect(page).to have_no_content "Sign In"
    expect(page).to have_content "John Doe"
    expect(page).to have_content "Sign Out"
  end

  scenario "User signs up, missing email" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Email", with: ""
    fill_in "Password", with: "john"
    fill_in "Password confirmation", with: "john"
    within ".actions" do
      click_on "Sign Up"
    end
    expect(page).to have_content "Email can't be blank"
  end

  scenario "User signs up, missing password" do
    visit root_path
    within ".navbar" do
      click_on "Sign Up"
    end
    fill_in "First name", with: "Leveon"
    fill_in "Last name", with: "Bell"
    fill_in "Email", with: "lbell@example.com"
    # Don't fill in passwords
    within ".actions" do
      click_on "Sign Up"
    end
    expect(page).to have_content "Password can't be blank"
  end
end
