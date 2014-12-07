require 'rails_helper'

feature "Projects" do
  before do
    @user = create_user
    sign_in @user
  end

  scenario "users can only see projects that they are members of" do
    membership = create_membership user: @user
    non_membership = create_membership
    visit projects_path
    expect(page).to have_content membership.project.name
    expect(page).to have_no_content non_membership.project.name
  end

  scenario "User creates a project" do
    visit projects_path
    click_on "Create Project"
    fill_in "Name", with: "Take over the world"
    click_on "Create Project"
    expect(page).to have_content "Take over the world"
  end

  scenario "User edits a project" do
    project = create_project name: "woo!"
    membership = create_membership project: project, user: @user
    visit projects_path
    click_on "Edit"
    fill_in "Name", with: "woo two!"
    click_on "Update Project"
    expect(page).to have_content "woo two!"
  end

  scenario "User attempts to create a project without a name" do
    visit projects_path
    click_on "Create Project"
    click_on "Create Project"
    expect(page).to have_content "Name can't be blank"
  end

  scenario "User deletes a project from #show" do
    project = create_project
    rand(5).times do
      create_membership project: project, user: create_user
    end
    rand(5).times do
      create_task project: project
    end
    membership_count = Membership.all.count
    task_count = Task.all.count
    visit project_path(project)
    warning_message = "Deleting this project will also delete " + membership_count.to_s + " membership".pluralize(membership_count) + ", " + task_count.to_s + " task".pluralize(task_count) + " and associated comments"
    expect(page).to have_content warning_message
    click_on "Delete"
    expect(page).to have_content "Project was successfully deleted."
  end
end
