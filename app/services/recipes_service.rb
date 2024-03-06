class RecipesService 
  def conn
    Faraday.new(url: "https://api.edamam.com") do |faraday|
      faraday.params["app_id"] = Rails.application.credentials.edamam[:access_id]
      faraday.params["app_key"] = Rails.application.credentials.edamam[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def recipes_by_country(country)
    recipes = get_url("/api/recipes/v2?q=#{country}&type=public&random=true")
  end
end