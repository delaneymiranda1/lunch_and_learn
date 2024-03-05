require "rails_helper"

RSpec.describe Video do
  it "exists" do
    attrs = {
      :snippet => {
        :title => "A Super Quick History of the Maldives", },
      :id => {:videoId => "nh-CT4FRICg"}
    }
    video = Video.new(attrs)

    expect(video.title).to eq("A Super Quick History of the Maldives")
    expect(video.video_id).to eq("nh-CT4FRICg")
  end
end