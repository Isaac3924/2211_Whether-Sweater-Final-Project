class Api::V1::SalariesController < ApplicationController
  def index
    salaries = SalariesFacade.new(params[:destination]).get_salaries
    forecast = ForecastFacade.new(MapFacade.new(params[:destination]).coordinates).forecast
    require 'pry'; binding.pry
    render json: SalariesSerializer.format_salaries(params[:destination], salaries, forecast)
  end
end