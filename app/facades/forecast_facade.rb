class ForecastFacade
  attr_reader :formatted_coordinates

  def initialize(coordinates)
    @formatted_coordinates = "#{coordinates[:lat]},#{coordinates[:lng]}"
  end

  def forecast
    forecast = service.get_forecast(@formatted_coordinates)
  end

  def current
    forecast[:current]
  end

  def current_weather
    {
      last_updated: current[:last_updated],
      temperature: current[:temp_f],
      feels_like: current[:feelslike_f],
      humidity: current[:humidity],
      uvi: current[:uv],
      visibility: current[:vis_miles],
      condition: current[:condition][:text],
      icon: current[:condition][:icon]
     }
  end

  def upcoming_weather
    binding.pry
    forecast[:forecast][:forecastday].last(3).map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def hourly_weather
    forecast[:forecast][:forecastday].first[:hour].map do |hour|
      {
        time: hour[:time].slice(-5, 5),
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end

  def eta_forecast(arrival_time)
    if arrival_time == "N/A"
      {temp_f: "", condition: {text: ""}}
    else
      forecast[:forecast][:forecastday].each do |date|
        if date[:date] == arrival_time[0..9]
          date[:hour].each do |hour|
            if hour[:time] == arrival_time
              return hour
            end
          end
        end
      end
    end
  end

  private
  def service
    @service ||= ForecastService.new
  end
end