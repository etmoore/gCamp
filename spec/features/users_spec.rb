require 'rails_helper'

feature "Users" do
  scenario "user attemps to create a new user without a first name, last name, or email" do
    visit users_path
    click_on "New User"
    click_on "Create User"
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email can't be blank"
  end
end
