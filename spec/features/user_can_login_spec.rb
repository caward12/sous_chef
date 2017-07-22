require 'rails_helper'

describe "User login" do
  it "user can log in with credentials" do
    user = User.create(first_name: "Bob", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test")

    visit "/login"

    fill_in "session[email]", with: "bob@aol.com"
    fill_in "session[password]", with: "test"
    click_on "Log In to Account"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome Bob")

  end
end