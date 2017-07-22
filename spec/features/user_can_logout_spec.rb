require 'rails_helper'

describe "user" do
  it "can log out" do
    user = User.create(first_name: "Bob", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test")

    login_user(user)

    expect(page).to have_content("Log Out")

    click_on "Log Out"

    expect(current_path).to eq(root_path)
  end
end