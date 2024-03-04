require "rails_helper"

RSpec.describe LatlonFacade do
  describe "#find_latlon" do
    it "finds latitude and longitude for given capital", :vcr do
      latlon = LatlonFacade.new.find_latlon("Denver", 80110)

      expect(latlon).to be_an(Array)
      expect(latlon.first).to be_a(Float)
      expect(latlon.last).to be_a(Float)
    end
  end
end