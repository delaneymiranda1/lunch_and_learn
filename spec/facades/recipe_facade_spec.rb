require "rails_helper"

RSpec.describe RecipesFacade do
  describe "#search_by_country" do
    it "returns a list of recipes for a country", :vcr do
      facade = RecipesFacade.new.search_by_country("thailand")

      expect(facade).to be_a(Array)
      expect(facade.first).to be_a(Recipe)
    end
  end
end