require "rails_helper"

RSpec.describe "Api::V1::Countries", type: :request do
  describe "get /api/v1/learning_resources?country=thailand" do

    it "returns image and video for a given country", :vcr do
      get "/api/v1/learning_resources?country=thailand"

      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data][:id]).to eq nil
      expect(json_response[:data][:type]).to eq ("learning_resource")
      expect(json_response[:data][:attributes][:country]).to eq ("thailand")
      
    end

    it 'returns empty array if no images are found', :vcr do
      get "/api/v1/learning_resources?country="

      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[:data][:attributes][:images]).to eq([])
    end

    it 'returns empty hash if no videos are found', :vcr do
      get "/api/v1/learning_resources?country="

      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response[:data][:attributes][:video]).to eq({})
    end
  end
end