require 'rails_helper'

RSpec.describe LatlonService do
  describe "#get_latlon" do
    it 'retrieves the latitude and longitude of a capital city', :vcr do
      latlon = LatlonService.new.get_latlon("Denver", 80110)

      expect(latlon).to be_a Hash
      # require 'pry'; binding.pry
      expect(latlon[:lat]).to be_a Float
      expect(latlon[:lon]).to be_a Float
      
    end
  end
end