require "rails_helper"

RSpec.describe AirQualityService, type: :service do
  describe "#current_quality" do
    it "returns current air quality data", :vcr do
      data = AirQualityService.new.current_quality(50, 50)

      expect(data).to be_a(Hash)
      air_quality = data[:list].first
      expect(air_quality[:main][:aqi]).to be_a Integer
      expect(air_quality[:components][:co]).to be_a Float
      expect(air_quality[:components][:no]).to be_a Integer
      expect(air_quality[:components][:no2]).to be_a Float
      expect(air_quality[:components][:o3]).to be_a Float
      expect(air_quality[:components][:so2]).to be_a Float
      expect(air_quality[:components][:pm2_5]).to be_a Float
      expect(air_quality[:components][:pm10]).to be_a Float
      expect(air_quality[:components][:nh3]).to be_a Float
      expect(air_quality[:dt]).to be_a Integer
    end
  end
end