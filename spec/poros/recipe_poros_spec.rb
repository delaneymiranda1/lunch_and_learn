require "rails_helper"

RSpec.describe Recipe do
  it "exists" do
    attrs = {
      id: nil,
      type: "recipe",
      title: "Lamb Chops",
      url: "http://lampchops.com",
      image: "image.jpg"
    }

    recipe = Recipe.new(attrs)
    
    expect(recipe).to be_a Recipe
    expect(recipe.type).to eq("recipe")
    expect(recipe.title).to eq("Lamb Chops")
    expect(recipe.url).to eq("http://lampchops.com")
    expect(recipe.image).to eq("image.jpg")
  end
end