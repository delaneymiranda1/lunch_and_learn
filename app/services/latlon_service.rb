class LatlonService

  def get_latlon(city, zip)
    get_url("direct?q=#{city},#{zip}&limit=1").first
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    conn = Faraday.new(url: "http://api.openweathermap.org/geo/1.0/") do |faraday|
      faraday.params[:appid] = Rails.application.credentials[:weather][:weather_key]
    end
  end
end