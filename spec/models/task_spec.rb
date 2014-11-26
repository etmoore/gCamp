require 'rails_helper'

describe Task do
  it "validates that the due date is not in the past" do
    task = Task.new description: 'past task', due: Date.today - 1
    task.valid?
    expect(task.errors[:due].present?).to eq(true)
  end

  it "validates that the task has a description" do
    task = Task.new
    task.valid?
    expect(task.errors[:due].present?).to eq(true)
  end
end
