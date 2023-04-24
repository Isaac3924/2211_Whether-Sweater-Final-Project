class Api::V1::SalariesController < ApplicationController
  def index
    forecast = SalariesFacade.new(MapFacade.new(params[:location]).coordinates).forecast
    render json: SalariesSerializer.format_forecast(forecast)
  end
end