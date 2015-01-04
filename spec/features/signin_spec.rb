require 'rails_helper'

feature "Sign In" do
  scenario "User signs in with valid information" do
    User.create first_name: "Testy", last_name: "McTest", email: "test@test.com",
                password: "test", password_confirmation: "test"
    visit signin_path
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
    visit signin_path
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
    visit signin_path
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "testy"
    within ".actions" do
      click_on "Sign In"
    end
    expect(page).to have_content "Username/password combination is invalid."
  end

  scenario "Visitors are redirected to signin page when trying to access a resource" do
    visit projects_path
    expect(page).to have_content "You must be logged in to access that action"
  end

  scenario "User is redirected to page they were trying to access after logging in" do
    @admin = create_user admin: true
    @project = create_project
    visit project_memberships_path(@project)
    expect(page).to have_content "You must be logged in to access that action"
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    within ".actions" do
      click_on "Sign In"
    end
    expect(page).to have_content "Manage Members"
  end
end
