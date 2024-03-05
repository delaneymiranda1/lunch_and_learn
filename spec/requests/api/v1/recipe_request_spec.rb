require "rails_helper"

RSpec.describe "Api::V1::Recipes", type: :request do
  describe "get /api/v1/recipes?country=thailand" do

    it "returns a list of recipes", :vcr do
      get "/api/v1/recipes?country=thailand"

      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response[:data].count).to eq 20
      expect(json_response[:data][1][:id]).to eq(nil)
      expect(json_response[:data][1][:type]).to eq('recipe')

      json = json_response[:data][1][:attributes]
      expect(json).to have_key :title
      expect(json[:title]).to be_a String
      expect(json).to have_key :url
      expect(json[:url]).to be_a String
      expect(json).to have_key :image
      expect(json[:image]).to be_a String

      expect(json).to_not have_key :images
      expect(json).to_not have_key :uri
      expect(json).to_not have_key :shareAs
      expect(json).to_not have_key :yield
    end

    it "returns a list of recipes from a random country if no country is given", :vcr do
      get "/api/v1/recipes?country="

      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(json_response[:data][1][:type]).to eq("recipe")
    end

    it "returns empty array if country given doesn't return recipes", :vcr do
      get "/api/v1/recipes?country=jsfklad"

      expect(response).to be_successful
      json_response = JSON.parse(response.body, symbolize_names: true)
    
      expect(json_response[:data]).to eq []
    end

    # it "returns empty array if empty string is given", :vcr do
    #   get "/api/v1/recipes?country= "

    #   expect(response).to be_successful
    #   json_response = JSON.parse(response.body, symbolize_names: true)

    #   expect(json_response[:data]).to eq []
    # end
  end
end