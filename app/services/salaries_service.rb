class SalariesService
  def get_jobs(location)
    get_url("/api/urban_areas/slug:#{location}/salaries/")
  end

  def conn
    Faraday.new(url: "https://api.teleport.org")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end 
end