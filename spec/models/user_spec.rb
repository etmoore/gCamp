require 'rails_helper'

describe User do
  it "Validates email uniqueness" do
    user = User.create first_name: 'Aaron', last_name: 'Rogers', email: 'arod@arod.com',
                        password: 'arod', password_confirmation: 'arod'
    dup_user = User.create first_name: 'Aaron', last_name: 'Rogers', email: 'arod@arod.com',
                        password: 'arod', password_confirmation: 'arod'
    dup_user.valid?
    expect(dup_user.errors[:email].present?).to eq(true)
  end

  it "Validates first_name and last_Name presence" do
    user = User.new
    user.valid?
    expect(user.errors[:first_name].present?).to eq(true)
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
