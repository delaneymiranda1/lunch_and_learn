require "rails_helper"

RSpec.describe Image do
  it "exists" do
    attrs = {
      url: "https://www.pexels.com/photo/large-tree-on-field-on-foggy-morning-in-thailand-16047692/",
      src: {
        original: "https://images.pexels.com/photos/16047692/pexels-photo-16047692.jpeg",
      }
    }
    image = Image.new(attrs)

    expect(image.url).to eq("https://www.pexels.com/photo/large-tree-on-field-on-foggy-morning-in-thailand-16047692/")
    expect(image.tag).to eq("https://images.pexels.com/photos/16047692/pexels-photo-16047692.jpeg")
  end
end