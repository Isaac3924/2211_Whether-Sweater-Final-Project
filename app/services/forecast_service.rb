class ForecastService
  def get_forecast(location)
    get_url("/v1/forecast.json?&days=3", {q: location})
  end

  def conn
    Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params["key"] = ENV["WEATHER_DATABASE_KEY"]
    end
  end

  def get_url(url, query = nil)
    response = conn.get(url, query)
    JSON.parse(response.body, symbolize_names: true)
  end 
end