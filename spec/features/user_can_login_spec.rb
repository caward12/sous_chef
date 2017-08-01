require 'rails_helper'

describe "User login" do
  it "user can log in with credentials" do
    user = User.create(first_name: "Bob", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test")

    visit "/login"

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    click_on "Log In to Account"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome Bob")

  end

  it "cannot login with invalid password" do
    user = User.create(first_name: "Bob", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test")

    visit "/login"
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: "tes"
    click_on "Log In to Account"

    expect(page).to have_content("Unsuccessful sign in attempt")
  end

  it "cannot login with invalid email" do
    user = User.create(first_name: "Bob", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test")

    visit "/login"
    fill_in "session[email]", with: "bob@aol"
    fill_in "session[password]", with: user.password
    click_on "Log In to Account"

    expect(page).to have_content("Unsuccessful sign in attempt")
  end
end