require 'rails_helper'

feature "Projects" do
  scenario "User creates a project" do
    visit projects_path
    click_on "Create Project"
    fill_in "Name", with: "Take over the world"
    click_on "Create Project"
    expect(page).to have_content "Take over the world"
  end

  scenario "User edits a project" do
    Project.create name: "woo!"
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
end
