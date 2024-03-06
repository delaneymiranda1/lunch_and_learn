require "rails_helper"

RSpec.describe YoutubeService do
  describe "#get_videos_by_country" do
    it "returns array of videos for a given country", :vcr do
      videos = YoutubeService.new.get_videos_by_country("thailand")

      expect(videos).to be_an(Array)
      expect(videos.first).to be_a(Hash)
      expect(videos.first[:kind]).to be_a(String)
    end
  end
end