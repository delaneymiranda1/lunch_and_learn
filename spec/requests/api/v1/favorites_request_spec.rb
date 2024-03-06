require "rails_helper"

RSpec.describe "Favorites", type: :request do

  describe "POST /api/v1/favorites" do
    it "creates a user favorite" do
      user_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyf"
      }
  
      user = User.create!(user_params)
    
      recipe = {
        "api_key": "#{user.api_key}",
        "country": "Thailand",
        "recipe_link": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
        "recipe_title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)"
      }

      headers = { "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }
      
      post "/api/v1/favorites", headers: headers, params: recipe.to_json
      
      json_response = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:created)
      expect(response.status).to eq(201)
      expect(user.favorites.first[:country]).to eq('Thailand')
      expect(user.favorites.first[:recipe_link]).to eq("https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html")
      expect(user.favorites.first[:recipe_title]).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
      expect(json_response[:success]).to eq("Favorite created successfully.")
      
    end

    it "error if creds are wrong" do
      user_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyf"
      }
  
      user = User.create!(user_params)

      recipe = {
        "api_key": "kfjalfhskf",
        "country": "Thailand",
        "recipe_link": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
        "recipe_title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)"
      }

      headers = { "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }

      post "/api/v1/favorites", headers: headers, params: recipe.to_json

      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:unauthorized)
      expect(response.status).to eq(401)
      expect(json_response[:error]).to eq("Invalid API Key")
    end
  end

  describe "GET /api/v1/favorites" do
    it "returns all favorites belonging to a user" do
      user_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyf"
      }
  
      user = User.create!(user_params)

      favorite1 = user.favorites.create!(country: "Thailand", recipe_link: "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html", recipe_title: "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
      favorite2 = user.favorites.create!(country: "China", recipe_link: "https://food52.com/recipes/81155-peach-tart-with-amer", recipe_title: "Peach Tart with Amer")
      
      headers = { "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }

      get "/api/v1/favorites?api_key=#{user.api_key}", headers: headers

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      # require 'pry'; binding.pry
      expect(json_response[:data].first[:type]).to eq("favorite")
      expect(json_response[:data].first[:attributes][:recipe_title]).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
      expect(json_response[:data].last[:attributes][:recipe_title]).to eq("Peach Tart with Amer")
    end

    it "empty array if user has no favorites" do
      user_params = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyf"
      }
  
      user = User.create!(user_params)

      headers = { "CONTENT_TYPE" => "application/json",
        "ACCEPT" => "application/json"
      }

      get "/api/v1/favorites?api_key=#{user.api_key}", headers: headers

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(json_response[:data]).to eq([])
    end

    it "returns error with wrong api key" do
      get "/api/v1/favorites?api_key=kalfjdaks"

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)

      expect(json_response[:error]).to eq("Invalid API Key")
    end
  end
end