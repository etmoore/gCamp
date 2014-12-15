require 'rails_helper'

feature 'Memberships' do
  before do
    @user = create_user
    @project = create_project
    sign_in @user
  end
  scenario 'User creates a membership' do
    visit project_memberships_path(@project)
    select @user.full_name, from: "membership_user_id"
    select "Member", from: "membership_role"
    click_on "Add New Member"
    expect(page).to have_content @user.full_name
  end

  scenario 'Owner deletes a membership' do
    create_membership project: @project, user: @user, role: 'owner'
    visit project_memberships_path(@project)
    expect(page).to have_content @user.full_name

    find(".glyphicon-remove").click
    expect(page).to have_content "#{@user.full_name} was removed successfully"
  end
end
