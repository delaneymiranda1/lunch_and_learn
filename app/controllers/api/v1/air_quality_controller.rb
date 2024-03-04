class Api::V1::AirQualityController < ApplicationController

  def index

    capital = CountryService.new.get_capital(params[:country])
    coords = LatlonFacade.new.find_latlon(capital, nil)
    air_quality = AirQualityFacade.new.get_current_quality(coords.first, coords.last)
    render json: AirQualitySerializer.new(air_quality).serializable_hash
  end

end