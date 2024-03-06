require "rails_helper"

RSpec.describe "Favorites", type: :request do

  describe "POST /api/v1/favorites" do
    it "creates a user favorite" do
      user = User.create!(name: "Toad", email: "toad1@gmail.com", password: "yay1", password_confirmation: "yay1")
      params = {
        api_key: user.api_key,
        country: "thailand",
        recipe_link: "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
        recipe_title: "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)"
      }.to_json

      post "/api/v1/favorites", params: params, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }
      
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:created)
      expect(response.status).to eq(201)
      expect(json_response[:success]).to eq("Favorite created successfully.")
    end

    it "error if creds are wrong" do
      user = User.create!(name: "Toad", email: "toad1@gmail.com", password: "yay1", password_confirmation: "yay1")
      
      params = {
        api_key: "jdaksdfja",
        country: "thailand",
        recipe_link: "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
        recipe_title: "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)"
      }.to_json

      post "/api/v1/favorites", params: params, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:unauthorized)
      expect(response.status).to eq(401)
      expect(json_response[:error]).to eq("Invalid API Key")
    end
  end
end