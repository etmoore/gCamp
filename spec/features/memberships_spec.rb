require 'rails_helper'

feature 'Memberships' do
  before do
    @user = create_user
    @project = create_project

    @owner = create_user
    create_membership project: @project, user: @owner, role: 'owner'

    @member = create_user
    create_membership project: @project, user: @member, role: 'member'
  end

  scenario 'Owner creates a membership' do
    sign_in @owner

    visit project_memberships_path(@project)
    select @user.full_name, from: "membership_user_id"
    within ".well" do
      select "Member", from: "membership_role"
    end
    click_on "Add New Member"
    expect(page).to have_content @user.full_name
  end

  scenario 'Owner deletes a membership' do
    sign_in @owner

    visit project_memberships_path(@project)
    expect(page).to have_content @member.full_name
    remove_icons = page.all(".glyphicon-remove")
    remove_icons[1].click
    expect(page).to have_content "#{@member.full_name} was removed successfully"
  end

  scenario 'Member does not see forms on memberships index' do
    sign_in @member

    visit project_memberships_path(@project)
    expect(page).to have_no_content "Add New Member"
  end
end
