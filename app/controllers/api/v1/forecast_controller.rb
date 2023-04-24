class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.new(MapFacade.new(params[:location]).coordinates).forecast
    render json: ForecastSerializer.format_forecast(forecast)
  end
end