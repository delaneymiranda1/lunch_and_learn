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
      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to have_key(:name)
      expect(json_response[:data][:attributes]).to have_key(:email)
      expect(json_response[:data][:attributes]).to have_key(:api_key)
      expect(json_response[:data][:attributes][:name]).to eq("Odell")
      expect(json_response[:data][:attributes][:email]).to eq("goodboy@ruffruff.com")
    end

    it "fails to create a new user if passwords don't match" do
      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
      
      post "/api/v1/users", params: {
        user: {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf",
          "password_confirmation": "treats4lyffff"
        }
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(422)
      expect(json_response[:errors]).to eq(["Password confirmation doesn't match Password"])
    end

    it "fails to create a new user if email is taken" do
      User.create!(name: "Odell", email: "goodboy@ruffruff.com", password: "treats4lyf", password_confirmation: "treats4lyf")

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

      expect(response.status).to eq(422)
      expect(json_response[:errors]).to eq(["Email has already been taken"])
    end
  end
end