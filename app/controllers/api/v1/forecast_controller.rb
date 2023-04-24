class Api::V1::ForecastController < ApplicationController
  def show
    require 'pry'; binding.pry
    forecast = ForecastFacade.new(Mapfacade.new(params[:location]).coordinates)
    render json: ForecastSerializer.new(forecast)
  end
end