require "rails_helper"

describe User do
  it "encrypts its password" do
    user = User.new(password: "password")

    expect(user.encrypted_password).not_to include("password")
  end
end