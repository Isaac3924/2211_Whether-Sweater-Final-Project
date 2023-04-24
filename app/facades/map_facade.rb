class MapFacade
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def coordinates
    coordinates = service.get_coordinates(@location)[:results][0][:locations][0][:latLng]
  end

  private
  def service
    @service ||= MapService.new
  end
end