require 'rails_helper'

feature "Tasks" do
  before :each do
    @project = create_project
  end

  scenario "User creates a task" do
    visit project_tasks_path(@project)
    click_on "Create Task"
    fill_in "Description", with: "test task"
    fill_in "Due", with: Date.today + 7
    click_on "Create Task"
    expect(page).to have_content "Task was successfully created"
    expect(page).to have_content "test task"
  end

  scenario "User marks a task complete" do
    task = @project.tasks.create description: "test", due: Date.today + 7
    visit project_task_path(@project, task)
    click_on "Edit"
    check "Complete"
    click_on "Update Task"
    expect(page).to have_content "Complete: true"
  end

  scenario "User deletes a task" do
    @project.tasks.create description: "test", due: Date.today + 7
    visit project_tasks_path(@project)
    expect(page).to have_content "test"
    find(".glyphicon-remove").click
    expect(page).to have_no_content "test"
  end

  scenario "User edits a task description and date" do
    task = @project.tasks.create description: "test", due: "01/12/2014"
    visit project_task_path(@project, task)
    expect(page).to have_content "test"
    expect(page).to have_content "12/01/2014"
    click_on "Edit"
    fill_in "Description", with: "test edited"
    fill_in "Due", with: "02/12/2014"
    click_on "Update Task"
    expect(page).to have_content "test edited"
    expect(page).to have_content "12/02/2014"
  end

  scenario "User attempts to create a task without a description" do
    visit project_tasks_path(@project)
    click_on "Create Task"
    click_on "Create Task"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "User attempts to create a task due in the past" do
    visit project_tasks_path(@project)
    click_on "Create Task"
    fill_in "Description", with: "Past task"
    fill_in "Due", with: Date.today - 1
    click_on "Create Task"
    expect(page).to have_content "Due date has already passed"
  end

  scenario "(deleted user) shows up when the User who wrote a comment gets destroyed" do
    user = create_user
    project = create_project
    task = project.tasks.create( description: "test project" )
    task.comments.create( user_id: user, comment: "test comment")
    user.destroy
    visit project_task_path(project, task)
    expect(page).to have_content "(deleted user)"
  end
end
