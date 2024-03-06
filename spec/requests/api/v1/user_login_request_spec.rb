require "rails_helper"

RSpec.describe "Session", type: :request do

  describe "POST /api/v1/sessions" do
    it "logs in a user" do
      user_params = {
          "name": "Odell", 
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf"
      }

      user = User.create!(user_params)

      headers = { "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }

      post "/api/v1/sessions", headers: headers, params: user_params.to_json

      json_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(200)
      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to have_key(:name)
      expect(json_response[:data][:attributes]).to have_key(:email)
      expect(json_response[:data][:attributes]).to have_key(:api_key)
      expect(json_response[:data][:attributes][:name]).to eq('Odell')
      expect(json_response[:data][:attributes][:api_key]).to_not be_nil
    end

    it "throws error if password is not correct" do
      user_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyf"
      }
  
      user = User.create!(user_params)

      bad_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyffff"
      }
  
      headers = { "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }
  
      post '/api/v1/sessions', headers: headers, params: bad_params.to_json 
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(json_response[:error]).to eq("Invalid email or password")
    end

    it "throws error if email is not correct" do
      user_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyf"
      }
  
      user = User.create!(user_params)

      bad_params = {
        "name": "Odell",
        "email": "badboy@ruffruff.com",
        "password": "treats4lyf"
      }
  
      headers = { "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }
  
      post '/api/v1/sessions', headers: headers, params: bad_params.to_json 

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(json_response[:error]).to eq("Invalid email or password")
    end
  end
end