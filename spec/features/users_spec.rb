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

  scenario "user attempts to create a new user with duplicate email" do
    User.create first_name: "Joe",
                last_name: "Schmoe",
                email: "jschmoe@example.com",
                password: "test",
                password_confirmation: "test"
    visit users_path
    click_on "New User"
    fill_in "First name", with: "Bob"
    fill_in "Last name", with: "Cookabara"
    fill_in "Email", with: "jschmoe@example.com"
    fill_in "Password", with: 'testy'
    fill_in "Password confirmation", with: 'testy'
    click_on "Create User"
    expect(page).to have_content "Email has already been taken"
  end
end
