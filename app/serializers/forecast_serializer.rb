class ForecastSerializer
  include JSONAPI::Serializer

  def self.format_forecast(current_weather, upcoming_weather, hourly_weather)
    {
      data: 
      {
        id: nil,
        type: "forecast",
        attributes: 
        {
          current_weather: current_weather,

          daily_weather: upcoming_weather,

          hourly_weather: hourly_weather
        }
      }
    }
  end
end
