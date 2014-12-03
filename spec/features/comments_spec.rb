require 'rails_helper'

feature 'Comments' do
  before :each do
    @project = create_project
    @task = create_task project: @project

    # signin so the comments box will appear
    User.create first_name: "Testy", last_name: "McTest", email: "test@test.com",
    password: "test", password_confirmation: "test"
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "test"
    within ".actions" do
      click_on "Sign In"
    end
  end

  # scenario 'user creates a comment' do
  #   visit project_task_path(@project, @task)
  #   fill_in '#comment_comment', with: "this is a comment"
  #   click_on "Add Comment"
  #   expect(page).to have_content "this is a comment"
  # end
end
