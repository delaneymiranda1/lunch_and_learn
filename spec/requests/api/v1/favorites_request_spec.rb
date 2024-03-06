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

  describe "GET /api/v1/favorites" do
    it "returns all favorites belonging to a user" do
      user = User.create!(name: "Goomba", email: "goomba1@gmail.com", password: "goo123", password_confirmation: "goo123")
      favorite1 = user.favorites.create!(country: "Thailand", recipe_link: "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html", recipe_title: "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
      favorite2 = user.favorites.create!(country: "China", recipe_link: "https://food52.com/recipes/81155-peach-tart-with-amer", recipe_title: "Peach Tart with Amer")
      get "/api/v1/favorites?api_key=#{user.api_key}", headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json_response[:data][:type]).to eq("favorite")
      expect(json_response[:data].first[:attributes][:recipe_title]).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
      expect(json_response[:data].last[:attributes][:recipe_title]).to eq("Peach Tart with Amer")
    end
  end
end