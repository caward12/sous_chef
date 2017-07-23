require 'rails_helper'

describe "user" do
  xit "can return single user" do
    user1 = User.create(first_name: "Colleen", last_name: "Smith", email: "smith@aol.com", password: "1234")

    get '/api/v1/users/1'

    expect(response).to be_success

    user = JSON.parse(response.body)

    expect(user["first_name"]).to eq(user1.first_name)
    expect(user["last_name"]).to eq(user1.last_name)
    expect(user["email"]).to eq(user1.email)
  end

  xit "can create a new user" do

    user_params = {first_name: "Bob", last_name: "Jones", email: "bob@aol.com", password: "test", password_confirmation: "test"}
    post "/api/v1/users", params: user_params

    expect(response).to be_success

    expect(User.count).to eq(1)
  end
end