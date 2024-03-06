require "rails_helper"

RSpec.describe PexelService, type: :service do

  describe "images" do
    it "returns images for a given country", :vcr do
    
      images = PexelService.new.images('thailand')

      expect(images).to be_a Hash
      expect(images[:photos].first[:url]).to be_a String
    end
  end
end