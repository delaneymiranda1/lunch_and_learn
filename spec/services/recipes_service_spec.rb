require "rails_helper"

RSpec.describe RecipesService, vcr: true, type: :service do
  describe "get recipes for given country" do
    it "returns a list of recipes" do
      search = RecipesService.new.recipes_by_country('thailand')
      expect(search).to be_a Hash
      # require 'pry'; binding.pry
      recipe = search[:hits]
      expect(recipe).to be_a Array

    end
  end
end