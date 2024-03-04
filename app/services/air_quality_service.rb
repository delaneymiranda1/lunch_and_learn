class AirQualityService 
  def conn
    conn = Faraday.new(url: "http://api.openweathermap.org/data/2.5/air_pollution") do |faraday|
      faraday.params[:appid] = Rails.application.credentials[:weather][:weather_key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def current_quality(lat, lon)
    current = get_url("?lat=#{lat}&lon=#{lon}")
  end
end