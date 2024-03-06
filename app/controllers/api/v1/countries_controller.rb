class Api::V1::CountriesController < ApplicationController

  def show
    country = params[:country]
    video = YoutubeFacade.new.get_a_country(country)
    images = PexelFacade.new.image_search(country)

    data = {
      video: video,
      images: images,
      country: country
    }
    render json: MediaSerializer.new(data).serializable_hash.to_json
  end
end