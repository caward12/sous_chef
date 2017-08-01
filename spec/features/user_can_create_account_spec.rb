require 'rails_helper'

describe "guest user" do
  it "can create a new account" do
    visit "/"

    click_on "Create Account"

    expect(current_path).to eq(new_user_path)

    fill_in "user[first_name]", with: "Bob"
    fill_in "user[last_name]", with: "Jones"
    fill_in "user[email]", with: "bob@aol.com"
    fill_in "user[password]", with: "1234"
    fill_in "user[password_confirmation]", with: "1234"
    click_on "Create Account"

    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_content("Welcome Bob")
  end

  it "cannot create account without password confirmation" do
    visit "/"

    click_on "Create Account"

    expect(current_path).to eq(new_user_path)

    fill_in "user[first_name]", with: "Bob"
    fill_in "user[last_name]", with: "Jones"
    fill_in "user[email]", with: "bob@aol.com"
    fill_in "user[password]", with: "1234"
    click_on "Create Account"

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it "can cannot create account without email" do
    visit "/"

    click_on "Create Account"

    expect(current_path).to eq(new_user_path)

    fill_in "user[first_name]", with: "Bob"
    fill_in "user[last_name]", with: "Jones"
    fill_in "user[password]", with: "1234"
    fill_in "user[password_confirmation]", with: "1234"
    click_on "Create Account"

    expect(page).to have_content("Email can't be blank")
  end

  it "can not create a new account without password" do
    visit "/"

    click_on "Create Account"

    expect(current_path).to eq(new_user_path)

    fill_in "user[first_name]", with: "Bob"
    fill_in "user[last_name]", with: "Jones"
    fill_in "user[email]", with: "bob@aol.com"
    fill_in "user[password_confirmation]", with: "1234"
    click_on "Create Account"

    expect(page).to have_content("Password can't be blank")
  end

  it "can not create a new account with email already used" do
    User.create(first_name: "Sue", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test")
    visit "/"

    click_on "Create Account"

    expect(current_path).to eq(new_user_path)

    fill_in "user[first_name]", with: "Bob"
    fill_in "user[last_name]", with: "Jones"
    fill_in "user[email]", with: "bob@aol.com"
    fill_in "user[password]", with: "1234"
    fill_in "user[password_confirmation]", with: "1234"
    click_on "Create Account"

    expect(page).to have_content("Email has already been taken")
  end
end