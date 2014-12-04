require 'rails_helper'

describe Project do
  it "validates the presence of name" do
    project = new_project name: nil
    expect(project.valid?).to eq(false)
  end

  it "destroys associated models (memberships, tasks, comments) when it gets destroyed" do
    project = create_project
    membership = create_membership project: project
    task = create_task project: project
    comment = create_comment task: task, user: membership.user

    expect(project.memberships.count).to eq(1)
    expect(project.tasks.count).to eq(1)
    expect(task.comments.count).to eq(1)

    project.destroy
    expect(project.memberships.count).to eq(0)
    expect(project.tasks.count).to eq(0)
    expect(task.comments.count).to eq(0)

  end
end
