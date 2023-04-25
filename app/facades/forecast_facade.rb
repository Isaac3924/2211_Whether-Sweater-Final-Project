class ForecastFacade
  attr_reader :formatted_coordinates

  def initialize(coordinates)
    @formatted_coordinates = "#{coordinates[:lat]},#{coordinates[:lng]}"
  end

  def forecast
    forecast = service.get_forecast(@formatted_coordinates)
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