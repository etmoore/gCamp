require 'rails_helper'

describe Project do
  it "validates the presence of name" do
    project = new_project name: nil
    expect(project.valid?).to eq(false)
  end
end
