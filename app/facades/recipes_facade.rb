class RecipesFacade
  
  def search_by_country(country)
    service = RecipesService.new
    if country.present?
      response = service.recipes_by_country(country)
    else
      random_country = CountryService.new.get_random_country
      response = service.recipes_by_country(random_country)
    end

    recipes = response[:hits] || []

    return [] if recipes.empty?

    recipes.map { |recipe| Recipe.new(recipe[:recipe])}
    
  end
end