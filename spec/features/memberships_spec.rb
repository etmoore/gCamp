require 'rails_helper'

feature 'Memberships' do
  before do
    @user = create_user
    @project = create_project
    create_membership project: @project, user: @user, role: 'owner'
    @member_user = create_user
    sign_in @user
  end
  scenario 'User creates a membership' do
    visit project_memberships_path(@project)
    select @member_user.full_name, from: "membership_user_id"
    within ".well" do
      select "Member", from: "membership_role"
    end
    click_on "Add New Member"
    expect(page).to have_content @user.full_name
  end

  scenario 'Owner deletes a membership' do
    create_membership project: @project, user: @member_user, role: 'member'
    visit project_memberships_path(@project)
    expect(page).to have_content @user.full_name
    remove_icons = page.all(".glyphicon-remove")
    remove_icons[1].click
    expect(page).to have_content "#{@member_user.full_name} was removed successfully"
  end
end
