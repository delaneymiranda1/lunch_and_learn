require "rails_helper"

RSpec.describe AirQualityFacade do
  describe "#get_current_quality", :vcr do
    it "returns pollution data at given coordinates" do
      air_quality = AirQualityFacade.new.get_current_quality(50, 50)

      expect(air_quality).to be_a(AirQuality)
    end
  end
end