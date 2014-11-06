require 'rails_helper'

feature "Signup" do
  scenario "User signs up" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Willie"
    fill_in "Last name", with: "Nelson"
    fill_in "Email", with: "wnels@example.com"
    fill_in "Password", with: "willie"
    fill_in "Password confirmation", with: "willie"
    within(".actions") do
      click_on("Sign Up")
    end
    expect(page).to have_no_content("Sign Up")
    expect(page).to have_no_content("Sign In")
    expect(page).to have_content("Willie Nelson")
    expect(page).to have_content("Sign Out")
  end
end
