require 'rails_helper'

feature "Projects" do
  scenario "User attempts to create a project without a name" do
    visit projects_path
    click_on "Create Project"
    click_on "Create Project"
    expect(page).to have_content "Name can't be blank"
  end
end
