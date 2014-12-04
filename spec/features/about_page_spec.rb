require 'rails_helper'

feature 'About page' do
  before :each do
    @projects = Project.all
    @tasks = Task.all
    @memberships = Membership.all
    @users = User.all
    @comments = Comment.all
  end
  scenario 'shows the count of projects, tasks, members, users, and comments' do
    visit about_path
    expect(page).to have_content "#{@projects.count} " + "Project".pluralize(@projects.count)
    expect(page).to have_content "#{@tasks.count} " + "Task".pluralize(@tasks.count)
    expect(page).to have_content "#{@memberships.count} " + "Project Member".pluralize(@memberships.count)
    expect(page).to have_content "#{@users.count} " + "User".pluralize(@users.count)
    expect(page).to have_content "#{@comments.count} " + "Comment".pluralize(@comments.count)
  end
end
