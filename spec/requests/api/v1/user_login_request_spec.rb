require "rails_helper"

RSpec.describe "Session", type: :request do

  describe "POST /api/v1/sessions" do
    it "creates a new user" do
      user = User.create!(name: "Bowser", email: "bowser1@gmail.com", password: "ilovepeach1", password_confirmation: "ilovepeach1")

      post "/api/v1/sessions", params: {
        email: user.email,
        password: user.password
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry ... this test is working properly but the postman request is not
      expect(response.status).to eq(200)
      expect(json_response[:data][:attributes][:name]).to eq('Bowser')
      expect(json_response[:data][:attributes][:api_key]).to_not be_nil
    end

    it "throws error if password is not correct" do
      user = User.create!(name: "Yoshi", email: "yoshi1@gmail.com", password: "yoshii1", password_confirmation: "yoshii1")

      post "/api/v1/sessions", params: {
        email: user.email,
        password: "yoshiiii1"
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(json_response[:error]).to eq("Invalid email or password")
    end

    it "throws error if email is not correct" do
      user = User.create!(name: "Peach", email: "peach1@gmail.com", password: "ihatebowser1", password_confirmation: "ihatebowser1")
      
      post "/api/v1/sessions", params: {
        email: "peach@gmail.com",
        password: user.password
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(401)
      expect(json_response[:error]).to eq("Invalid email or password")
    end
  end
end