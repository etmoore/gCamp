require 'rails_helper'

describe Comment do
  it "validates the presence of the comment body" do
    comment = new_comment comment: nil
    comment.valid?
    expect(comment.errors[:comment].present?).to eq(true)
  end
end
