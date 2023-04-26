class Api::V1::ForecastController < ApplicationController
  def index
    current_weather = ForecastFacade.new(MapFacade.new(params[:location]).coordinates).current_weather
    upcoming_weather = ForecastFacade.new(MapFacade.new(params[:location]).coordinates).upcoming_weather
    hourly_weather = ForecastFacade.new(MapFacade.new(params[:location]).coordinates).hourly_weather
    render json: ForecastSerializer.format_forecast(current_weather, upcoming_weather, hourly_weather)
  end
end