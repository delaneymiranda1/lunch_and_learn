require "rails_helper"

RSpec.describe "Users", type: :request do

  describe "POST /api/v1/users" do
    it "creates a new user in the database", :vcr do

      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }

      post "/api/v1/users", params: {
        user: {
              "name": "Odell",
              "email": "goodboy@ruffruff.com",
              "password": "treats4lyf",
              "password_confirmation": "treats4lyf"
            }

      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)
      expect(json_response[:data][:attributes][:name]).to eq("Odell")
      expect(json_response[:data][:attributes][:email]).to eq("goodboy@ruffruff.com")
    end
  end
end