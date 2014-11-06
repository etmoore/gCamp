require 'rails_helper'

feature "Sign Out" do
  scenario "User signs out" do
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
    click_on "Sign Out"
    expect(page).to have_content "Sign In"
    expect(page).to have_content "Sign Up"
    save_and_open_page
  end
end
