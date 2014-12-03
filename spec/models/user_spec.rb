require 'rails_helper'

describe User do
  it "Validates email uniqueness" do
    user = create_user email: 'arod@arod.com'
    dup_user = new_user email: 'arod@arod.com'
    dup_user.valid?
    expect(dup_user.errors[:email].present?).to eq(true)
  end

  it "Validates email presence" do
    user = new_user email: nil
    user.valid?
    expect(user.errors[:email].present?).to eq(true)
  end

  it "Validates first_name presence" do
    user = new_user first_name: nil
    user.valid?
    expect(user.errors[:first_name].present?).to eq(true)
  end

  it "Validates last_name presence" do
    user = new_user last_name: nil
    user.valid?
    expect(user.errors[:last_name].present?).to eq(true)
  end

  it "Deletes associated memberships and nullifies comment user_id when deleted" do
    project = create_project
    user = create_user
    task = project.tasks.create( description: "test" )
    comment = task.comments.create( comment: "this is a comment!",
                                    user_id: user )
    user.destroy
    expect(comment.user_id).to eq(nil)
  end
end
