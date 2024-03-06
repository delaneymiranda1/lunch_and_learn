require "rails_helper"

RSpec.describe YoutubeFacade do
  describe "#get_a_country" do
    it "returns a video for a given country", :vcr do
      video = YoutubeFacade.new.get_a_country("thailand")

      expect(video).to be_a(Video)
    end
  end
end