class CountryService

  def get_url(url)
    response = Faraday.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_countries
    get_country = get_url("https://restcountries.com/v3.1/all")
  end

  def get_random_country
    get_countries.sample[:name][:common]
  end
end