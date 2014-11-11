require 'rails_helper'

feature "Tasks" do
  scenario "User creates a task" do
    visit tasks_path
    click_on "Create Task"
    fill_in "Description", with: "test task"
    fill_in "Due", with: "12/1/14"
    click_on "Create Task"
    expect(page).to have_content "Task was successfully created"
    expect(page).to have_content "test task"
  end

  scenario "User marks a task complete" do
    task = Task.create description: "test", due: "12/1/14"
    visit task_path(task)
    click_on "Edit"
    check "Complete"
    click_on "Update Task"
    expect(page).to have_content "Complete: true"
  end

  scenario "User deletes a task" do
    Task.create description: "test", due: "12/1/14"
    visit tasks_path
    expect(page).to have_content "test"
    click_on "Destroy"
    expect(page).to have_no_content "test"
  end

  scenario "User edits a task description and date" do
    task = Task.create description: "test", due: "01/12/2014"
    visit task_path(task)
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
    visit tasks_path
    click_on "Create Task"
    click_on "Create Task"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "User attempts to create a task due in the past" do
    visit tasks_path
    click_on "Create Task"
    fill_in "Description", with: "Past task"
    fill_in "Due", with: Date.yesterday
    save_and_open_page
    click_on "Create Task"
    expect(page).to have_content "Due date has already passed"
  end
end
