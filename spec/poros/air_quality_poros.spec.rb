require "rails_helper"

RSpec.describe AirQuality do
  it "exists" do
    attrs = {
          "coord": {
              "lon": 50,
              "lat": 50
            },
          "list": [
              {
                  "main": {
                      "aqi": 2
                  },
                  "components": {
                    "co": 270.37,
                    "no": 0.04,
                    "no2": 0.56,
                    "o3": 85.12,
                    "so2": 0.18,
                    "pm2_5": 1.94,
                    "pm10": 2.05,
                    "nh3": 1.27
                  },
                  "dt": 1709530017
                }
              ]
            }
    air_quality = AirQuality.new(attrs)

    expect(air_quality).to be_a(AirQuality)
    expect(air_quality.lon).to eql(50)
    expect(air_quality.lat).to eql(50)
    expect(air_quality.aqi).to eql(2)
    expect(air_quality.co).to eql(270.37)
    expect(air_quality.no).to eql(0.04)
    expect(air_quality.no2).to eql(0.56)
    expect(air_quality.o3).to eql(85.12)
    expect(air_quality.so2).to eql(0.18)
    expect(air_quality.pm2_5).to eql(1.94)
    expect(air_quality.pm10).to eql(2.05)
    expect(air_quality.nh3).to eql(1.27)
    expect(air_quality.dt).to eql(1709530017)
  end
end