require "rails_helper"

RSpec.describe PexelFacade do
  describe "#image_search" do
    it "returns an array of images", :vcr do
      images = PexelFacade.new.image_search("thailand")

      expect(images).to be_a(Array)
      expect(images.first).to be_an(Image)
    end
  end
end