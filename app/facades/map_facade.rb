class MapFacade
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def coordinates
    if check_city
      coordinates = service.get_coordinates(@location)[:results][0][:locations][0][:latLng]
    else
      # binding.pry
      render json: { error: 'Cannot find requested city coordinates' }, status: 400
    end
  end

  def check_city
    # binding.pry
    loc_array = service.get_coordinates(@location)[:results][0][:locations]
    loc_array.each do |loc|
      if loc[:adminArea5].downcase == @location.split(',').first.downcase
        return true
      end
    end
    return false
  end

  def directions(destination)
    if service.get_directions(@location, destination)[:route].keys.include?(:routeError)
      "impossible"
    else
      travel_time = service.get_directions(@location, destination)[:route]
    end
  end

  def travel_time(destination)
    if directions(destination) == "impossible"
      "impossible"
    else
      directions(destination)[:formattedTime]
    end
  end

  def arrival_time(destination)
    if directions(destination) == "impossible"
      "N/A"
    else
      travel_time_sec = directions(destination)[:time]
      current_time = Time.now
      arrival_time_calculation = current_time + travel_time_sec
      arrival_time = arrival_time_calculation.strftime("%Y-%m-%d %H:00")
    end
  end

  private
  def service
    @service ||= MapService.new
  end
end