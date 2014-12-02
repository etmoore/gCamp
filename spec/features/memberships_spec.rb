require 'rails_helper'

feature 'Memberships' do
  scenario 'User creates a membership' do
    user = create_user
    project = create_project
    visit project_memberships_path(project)
    select user.full_name, from: "membership_user_id"
    select "Member", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content user.full_name
  end

  scenario 'User deletes a membership' do
    user = create_user
    project = create_project
    visit project_memberships_path(project)
    select user.full_name, from: "membership_user_id"
    select "Member", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content user.full_name

    find(".glyphicon-remove").click
    expect(page).to have_content "#{user.full_name} was removed successfully"
  end
end
