class ForecastFacade
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def get_salaries
    salaries = service.get_jobs(@location)
  end

  private
  def service
    @service ||= SalariesService.new
  end
end