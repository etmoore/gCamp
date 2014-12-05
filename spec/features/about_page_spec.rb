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
    expect(page).to have_content @projects.count.to_s + " Project".pluralize(@projects.count)
    expect(page).to have_content @tasks.count.to_s + " Task".pluralize(@tasks.count)
    expect(page).to have_content @memberships.count.to_s + " Project Member".pluralize(@memberships.count)
    expect(page).to have_content @users.count.to_s + " User".pluralize(@users.count)
    expect(page).to have_content @comments.count.to_s + " Comment".pluralize(@comments.count)
  end
end
