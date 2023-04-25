class RoadTripSerializer
  include JSONAPI::Serializer

  def self.format_road_trip(start_city, end_city, travel_time, arrival_time, weather_at_eta)
    {
      data: 
      {
        id: nil,
        type: "road_trip",
        attributes: 
        {
          start_city: start_city,
          end_city: end_city,
          travel_time: travel_time,
          weather_at_eta:
           {
            date_time: arrival_time,
            temperature: weather_at_eta[:temp_f],
            condition: weather_at_eta[:condition][:text]
           }
        }
      }
    }
  end
end
