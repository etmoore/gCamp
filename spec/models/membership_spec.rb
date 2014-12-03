require 'rails_helper'

describe Membership do
  it "validates role presence" do
    membership = new_membership role: nil
    membership.valid?
    expect(membership.errors[:role].present?).to eq(true)
  end

  it "validates user presence" do
    membership = new_membership user: nil
    membership.valid?
    expect(membership.errors[:user].present?).to eq(true)
  end

  it "validates user uniqueness" do
    user = create_user
    project = create_project
    membership = create_membership user: user, project: project
    dup_membership = new_membership user: user, project: project
    dup_membership.valid?
    expect(dup_membership.errors[:user].present?).to eq(true)
  end
end
