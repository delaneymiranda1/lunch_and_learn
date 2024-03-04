require "rails_helper"

RSpec.describe "Api::V1::LearningResources", type: :request do
  describe "get /api/v1/learning_resources?country=thailand" do

    xit "returns a list of learning resources", :vcr do
      get "/api/v1/learning_resources?country=thailand"

      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data].count).to eq 20
      expect(json_response[:data][1][:id]).to eq(nil)
      expect(json_response[:data][1][:type]).to eq('learning_resource')

      json = json_response[:data][1][:attributes]
      expect(json).to have_key :country_name
      expect(json[:country_name]).to be_a String
      expect(json).to have_key :video
      expect(json[:video]).to be_a Hash
      expect(json[:video][:title]).to be_a String
      expect(json[:video][:youtube_video_id]).to be_a String
      expect(json).to have_key :images
      expect(json[:images]).to be_a Array
      expect(json[:images][:alt_tag]).to be_a String
      expect(json[:images][:url]).to be_a String
    end

    it 'returns '
  end
end