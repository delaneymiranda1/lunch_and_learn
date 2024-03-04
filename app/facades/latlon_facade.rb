class LatlonFacade

  def find_latlon(city, zip)
    service = LatlonService.new
    call = service.get_latlon(city, zip)
    coords = [] << call[:lat] << call[:lon]
  end
end