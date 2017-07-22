require 'rails_helper'

describe "login" do
  it "can log an existing user in" do
    user = User.create(first_name: "Bob", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test")
    credentials= {email: "bob@aol.com", password: "test"}
    post "/api/v1/login", params: credentials

    expect(response).to be_success

    loggedin_user = JSON.parse(response.body)

    expect(loggedin_user["first_name"]).to eq(user.first_name)
    expect(loggedin_user["last_name"]).to eq(user.last_name)
    expect(loggedin_user["email"]).to eq(user.email)

  end
end