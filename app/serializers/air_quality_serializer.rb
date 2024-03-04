class AirQualitySerializer
  include JSONAPI::Serializer

  set_id { nil }
  set_type :air_quality

  attribute :aqi
  attribute :datetime do |date|
    date.dt
  end

  attribute :readable_aqi do |raq|
    readable_aqi(raq.aqi)
  end

  private 

  def self.readable_aqi(aqi)
    case aqi
    when 1
      'Good'
    when 2
      'Fair'
    when 3
      'Moderate'
    when 4
      'Poor'
    when 5
      'Very Poor'
    else
      'Unknown'
    end
  end
end