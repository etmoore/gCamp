require 'rails_helper'

describe Task do
  it "validates that the due date is not in the past" do
    task = new_task due: Date.today - 1
    task.valid?
    expect(task.errors[:due].present?).to eq(true)
  end

  it "validates that the task has a description" do
    task = new_task description: nil
    task.valid?
    expect(task.errors[:description].present?).to eq(true)
  end

  it "destroys related comments when destroyed" do
    task = create_task
    comment = create_comment task: task, user: new_user
    expect(task.comments.count).to eq(1)
    task.destroy
    expect(Comment.all.count).to eq(0)
  end

end
