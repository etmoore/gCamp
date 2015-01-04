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

  scenario "user edits themselves" do
    visit user_path(@user)
    click_on "Edit"
    fill_in "First name", with: "Bob"
    fill_in "Last name", with: "Cookabara"
    fill_in "Email", with: "jschmoe@example.com"
    fill_in "Password", with: 'testy'
    fill_in "Password confirmation", with: 'testy'
    click_on "Update User"
    expect(page).to have_content "Bob"
  end

  scenario "user should not see edit button for other users on show page" do
    other_user = create_user
    visit user_path(other_user)
    expect(page).to have_no_content "Edit"
  end

  scenario "admin deletes a user" do
    admin = create_user admin: true
    sign_in admin
    doomed_user = create_user
    visit edit_user_path(doomed_user)
    click_on "Delete User"
    expect(page).to have_content "User was successfully destroyed."
    expect(page).to have_no_content "Bob"
  end

  scenario "admin checkbox only appears for admins" do
    visit new_user_path
    expect(page).to have_no_content "Admin"

    @admin = create_user admin: true
    sign_in(@admin)
    visit new_user_path
    expect(page).to have_content "Admin"
  end

  scenario "user can only see email addresses of project co-members" do
    project = create_project
    create_membership user: @user, project: project
    co_member = create_user; create_membership user: co_member, project: project
    non_member = create_user
    visit users_path
    expect(page).to have_content co_member.email
    expect(page).to have_no_content non_member.email
  end

  scenario "admin can see all email addresses on the user index page" do
    @admin = create_user admin: true
    sign_in(@admin)
    third_user = create_user
    visit users_path
    save_and_open_page
    expect(page).to have_content @admin.email
    expect(page).to have_content @user.email
    expect(page).to have_content third_user.email
  end

end
