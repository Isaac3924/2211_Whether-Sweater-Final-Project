class MapService
  def get_coordinates(location)
    get_url("/geocoding/v1/address?", {location: location})
  end

  def conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = ENV["MAPQUEST_DATABASE_KEY"]
    end
  end

  def get_url(url, query = nil)
    response = conn.get(url, query)
    JSON.parse(response.body, symbolize_names: true)
  end 
end