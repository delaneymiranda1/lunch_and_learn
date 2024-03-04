require "rails_helper"

RSpec.describe "air quality requests", type: :request do
  describe "GET /api/v1/air_quality?country=India", :vcr do
    it "returns a list of air quality data for input country" do
      get "/api/v1/air_quality?country=India"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      
      expect(json_response[:data][:id]).to eq nil
      expect(json_response[:data][:type]).to eq("air_quality")
      expect(json_response[:data][:attributes][:aqi]).to be_a Integer
      expect(json_response[:data][:attributes][:datetime]).to be_a Integer
      expect(json_response[:data][:attributes][:readable_aqi]).to be_a String
    end

    it "can do it again with another country", :vcr do
      get "/api/v1/air_quality?country=Kenya"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(json_response[:data][:id]).to eq nil
      expect(json_response[:data][:type]).to eq("air_quality")
      expect(json_response[:data][:attributes][:aqi]).to be_a Integer
      expect(json_response[:data][:attributes][:datetime]).to be_a Integer
      expect(json_response[:data][:attributes][:readable_aqi]).to be_a String
    end

    it "can do it again with another Peru", :vcr do
      get "/api/v1/air_quality?country=Peru"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(json_response[:data][:id]).to eq nil
      expect(json_response[:data][:type]).to eq("air_quality")
      expect(json_response[:data][:attributes][:aqi]).to be_a Integer
      expect(json_response[:data][:attributes][:datetime]).to be_a Integer
      expect(json_response[:data][:attributes][:readable_aqi]).to be_a String
    end

    it "can do it again with another France" do
      get "/api/v1/air_quality?country=France"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(json_response[:data][:id]).to eq nil
      expect(json_response[:data][:type]).to eq("air_quality")
      expect(json_response[:data][:attributes][:aqi]).to be_a Integer
      expect(json_response[:data][:attributes][:datetime]).to be_a Integer
      expect(json_response[:data][:attributes][:readable_aqi]).to be_a String
    end

    it "can do it again with another Iceland" do
      get "/api/v1/air_quality?country=Iceland"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json_response[:data][:id]).to eq nil
      expect(json_response[:data][:type]).to eq("air_quality")
      expect(json_response[:data][:attributes][:aqi]).to be_a Integer
      expect(json_response[:data][:attributes][:datetime]).to be_a Integer
      expect(json_response[:data][:attributes][:readable_aqi]).to be_a String
    end
  end
end