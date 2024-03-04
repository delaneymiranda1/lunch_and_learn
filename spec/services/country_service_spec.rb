require "rails_helper"

RSpec.describe CountryService, type: :service do

  describe "get_countries" do
    it "returns a list of countries", :vcr do
      countries = CountryService.new.get_countries

      expect(countries).to be_a(Array)
      expect(countries.first).to be_a(Hash)
      expect(countries.first[:name][:common]).to be_a(String)
    end
  end

  describe "random_country" do
    it "returns a random country", :vcr do
      country = CountryService.new.get_random_country

      expect(country).to be_a(String)
    end
  end

  describe "#get_capital" do
    it "returns the capital of a country", :vcr do
      capital = CountryService.new.get_capital("India")

      expect(capital).to be_a(String)
    end
  end
end