class ForecastFacade
  attr_reader :formatted_coordinates

  def initialize(coordinates)
    @formatted_coordinates = "#{coordinates[:lat]},#{coordinates[:lng]}"
  end

  def forecast
    forecast = service.get_forecast(@formatted_coordinates)
  end

  private
  def service
    @service ||= ForecastService.new
  end
end