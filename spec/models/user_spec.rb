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
end
