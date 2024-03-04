class AirQualityFacade
  
  def get_current_quality(lat, lon)
    service = AirQualityService.new
    response = service.current_quality(lat, lon)
    AirQuality.new(response)
  end

end