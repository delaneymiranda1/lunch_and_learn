class CountryService

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_countries
    response = get_url("all")
  end

  def get_random_country
    get_countries.sample[:name][:common]
  end

  def get_capital(country)
    data = get_url("name/#{country}?fullText=true")
    data.first[:capital].first
  end

  def conn
    Faraday.new(url: "https://restcountries.com/v3.1/")
  end
end