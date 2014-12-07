require 'rails_helper'

feature "Sign Out" do
  scenario "User signs out" do
    user = create_user
    sign_in user
    expect(page).to have_content user.full_name
    expect(page).to have_content "Sign Out"
    click_on "Sign Out"
    expect(page).to have_content "Sign In"
    expect(page).to have_content "Sign Up"
  end
end
