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

    it "fails to create a new user if passwords don't match" do
      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
      
      post "/api/v1/users", params: {
        user: {
          name: "Mario",
          email: "supermario@bros.com",
          password: "yahoo123",
          password_confirmation: "yahooo123"
        }
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(json_response[:errors]).to eq(["Password confirmation doesn't match Password"])
    end

    it "fails to create a new user if email is taken" do
      User.create!(name: "Mario", email: "supermario@bros.com", password: "yahoo123", password_confirmation: "yahoo123")

      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
      
      post "/api/v1/users", params: {
        user: {
          name: "Luigi",
          email: "supermario@bros.com",
          password: "ohyeah123",
          password_confirmation: "ohyeah123"
        }
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(json_response[:errors]).to eq(["Email has already been taken"])
    end
  end
end