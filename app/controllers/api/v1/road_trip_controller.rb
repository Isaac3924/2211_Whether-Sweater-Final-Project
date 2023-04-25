class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: roadtrip_params[:api_key])
      travel_time = MapFacade.new(roadtrip_params[:destination]).travel_time(roadtrip_params[:origin])
      arrival_time = MapFacade.new(roadtrip_params[:destination]).arrival_time(roadtrip_params[:origin])
      eta_weather = ForecastFacade.new(MapFacade.new(roadtrip_params[:destination]).coordinates).eta_forecast(arrival_time)
      render json: RoadTripSerializer.format_road_trip(roadtrip_params[:origin], roadtrip_params[:destination], travel_time, arrival_time, eta_weather)
    else
      render json: {error: "Unauthorized"}, status: 401
    end
  end

  private
  def roadtrip_params
    params.permit(:origin, :destination, :api_key)
  end
end