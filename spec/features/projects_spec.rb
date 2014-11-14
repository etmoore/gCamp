require 'rails_helper'

feature "Projects" do
  scenario "User creates a project" do
    visit projects_path
    click_on "Create Project"
    fill_in "Name", with: "Take over the world"
    click_on "Create Project"
    expect(page).to have_content "Take over the world"
  end

  scenario "User attempts to create a project without a name" do
    visit projects_path
    click_on "Create Project"
    click_on "Create Project"
    expect(page).to have_content "Name can't be blank"
  end
end
