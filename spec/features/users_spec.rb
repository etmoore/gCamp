require 'rails_helper'

feature "Users" do
  before do
    @user = create_user
    sign_in @user
  end

  scenario "user creates a new user" do
    visit users_path
    click_on "New User"
    click_on "Create User"
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Smith"
    fill_in "Email", with: "jsmith@example.com"
    fill_in "Password", with: "yeah"
    fill_in "Password confirmation", with: "yeah"
    click_on "Create User"
    expect(page).to have_content "User successfully created."
  end

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

  scenario "user edits a user" do
    visit users_path
    click_on "Edit"
    fill_in "First name", with: "Bob"
    fill_in "Last name", with: "Cookabara"
    fill_in "Email", with: "jschmoe@example.com"
    fill_in "Password", with: 'testy'
    fill_in "Password confirmation", with: 'testy'
    click_on "Update User"
    expect(page).to have_content "Bob"
  end

  scenario "user deletes a user" do
    doomed_user = create_user
    visit edit_user_path(doomed_user)
    click_on "Delete User"
    expect(page).to have_content "User was successfully destroyed."
    expect(page).to have_no_content "Bob"
  end


end
