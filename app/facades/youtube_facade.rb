class YoutubeFacade

  def get_a_country(country)
    service = YoutubeService.new
    call = service.get_videos_by_country(country)
    if call.empty?
      {}
    else
      video = call.first
      Video.new(video)
    end
  end
end