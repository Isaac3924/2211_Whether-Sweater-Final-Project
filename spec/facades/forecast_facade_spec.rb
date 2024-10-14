require "rails_helper"

RSpec.describe ForecastFacade do
  before :each do
    @test_facade = ForecastFacade.new({:lat=>39.10713, :lng=>-84.50413})
  end

  describe "instance methods" do
    it "has formatted the hash of coordinates into a single string" do
      expect(@test_facade.formatted_coordinates).to eq("39.10713,-84.50413")
    end

    it "can return the appropriate weather json framework from the cordinate string", :vcr do
      json_body = @test_facade.forecast

      expect(json_body).to be_a(Hash)
      expect(json_body).to have_key(:current)
      expect(json_body[:current]).to have_key(:last_updated)
      expect(json_body[:current]).to have_key(:temp_f)
      expect(json_body[:current][:temp_f]).to be_a(Float)
      expect(json_body[:current]).to have_key(:feelslike_f)
      expect(json_body[:current][:feelslike_f]).to be_a(Float)
      expect(json_body[:current]).to have_key(:humidity)
      expect(json_body[:current][:humidity]).to be_a(Integer)
      expect(json_body[:current]).to have_key(:uv)
      expect(json_body[:current][:uv]).to be_a(Float)
      expect(json_body[:current]).to have_key(:vis_miles)
      expect(json_body[:current][:vis_miles]).to be_a(Float)
      expect(json_body[:current]).to have_key(:condition)
      expect(json_body[:current][:condition]).to be_a(Hash)
      expect(json_body[:current][:condition]).to have_key(:text)
      expect(json_body[:current][:condition][:text]).to be_a(String)
      expect(json_body[:current][:condition]).to have_key(:icon)
      expect(json_body[:current][:condition][:icon]).to be_a(String)
      expect(json_body).to have_key(:forecast)
      expect(json_body[:forecast]).to have_key(:forecastday)
      expect(json_body[:forecast][:forecastday]).to be_an(Array)
      expect(json_body[:forecast][:forecastday].length).to eq(3)
      expect(json_body[:forecast][:forecastday][1]).to have_key(:date)
      expect(json_body[:forecast][:forecastday][1][:date]).to be_a(String)
      expect(json_body[:forecast][:forecastday][1]).to have_key(:day)
      expect(json_body[:forecast][:forecastday][1]).to have_key(:astro)
      expect(json_body[:forecast][:forecastday][1][:astro]).to be_a(Hash)
      expect(json_body[:forecast][:forecastday][1][:astro]).to have_key(:sunrise)
      expect(json_body[:forecast][:forecastday][1][:astro][:sunrise]).to be_a(String)
      expect(json_body[:forecast][:forecastday][1][:astro]).to have_key(:sunset)
      expect(json_body[:forecast][:forecastday][1][:astro][:sunset]).to be_a(String)
      expect(json_body[:forecast][:forecastday][1][:day]).to be_a(Hash)
      expect(json_body[:forecast][:forecastday][1][:day]).to have_key(:maxtemp_f)
      expect(json_body[:forecast][:forecastday][1][:day][:maxtemp_f]).to be_a(Float)
      expect(json_body[:forecast][:forecastday][1][:day]).to have_key(:mintemp_f)
      expect(json_body[:forecast][:forecastday][1][:day][:mintemp_f]).to be_a(Float)
      expect(json_body[:forecast][:forecastday][1][:day]).to have_key(:condition)
      expect(json_body[:forecast][:forecastday][1][:day][:condition]).to be_a(Hash)
      expect(json_body[:forecast][:forecastday][1][:day][:condition]).to have_key(:text)
      expect(json_body[:forecast][:forecastday][1][:day][:condition][:text]).to be_a(String)
      expect(json_body[:forecast][:forecastday][1][:day][:condition]).to have_key(:icon)
      expect(json_body[:forecast][:forecastday][1][:day][:condition][:icon]).to be_a(String)
      expect(json_body[:forecast][:forecastday][0]).to have_key(:hour)
      expect(json_body[:forecast][:forecastday][0][:hour]).to be_an(Array)
      expect(json_body[:forecast][:forecastday][0][:hour].length).to eq(24)
      expect(json_body[:forecast][:forecastday][0][:hour][0]).to have_key(:time)
      expect(json_body[:forecast][:forecastday][0][:hour][0][:time]).to be_a(String)
      expect(json_body[:forecast][:forecastday][0][:hour][0]).to have_key(:temp_f)
      expect(json_body[:forecast][:forecastday][0][:hour][0][:temp_f]).to be_a(Float)
      expect(json_body[:forecast][:forecastday][0][:hour][0]).to have_key(:condition)
      expect(json_body[:forecast][:forecastday][0][:hour][0][:condition]).to be_a(Hash)
      expect(json_body[:forecast][:forecastday][0][:hour][0][:condition]).to have_key(:text)
      expect(json_body[:forecast][:forecastday][0][:hour][0][:condition][:text]).to be_a(String)
      expect(json_body[:forecast][:forecastday][0][:hour][0][:condition]).to have_key(:icon)
      expect(json_body[:forecast][:forecastday][0][:hour][0][:condition][:icon]).to be_a(String)
    end

    it "can return the current weather json framework from the cordinate string", :vcr do
      json_body = @test_facade.current_weather

      expect(json_body).to be_a(Hash)
      expect(json_body).to have_key(:last_updated)
      expect(json_body).to have_key(:temperature)
      expect(json_body[:temperature]).to be_a(Float)
      expect(json_body).to have_key(:feels_like)
      expect(json_body[:feels_like]).to be_a(Float)
      expect(json_body).to have_key(:humidity)
      expect(json_body[:humidity]).to be_a(Integer)
      expect(json_body).to have_key(:uvi)
      expect(json_body[:uvi]).to be_a(Float)
      expect(json_body).to have_key(:visibility)
      expect(json_body[:visibility]).to be_a(Float)
      expect(json_body).to have_key(:condition)
      expect(json_body[:condition]).to be_a(String)
      expect(json_body[:icon]).to be_a(String)
    end

    it "can return upcoming weather conditions based on time entered", :vcr do
      json_body = @test_facade.eta_forecast("2024-10-15 13:00")

      expect(json_body).to be_a(Hash)
      expect(json_body).to have_key(:time)
      expect(json_body[:time]).to be_a(String)
      expect(json_body).to have_key(:temp_f)
      expect(json_body[:temp_f]).to be_a(Float)
      expect(json_body).to have_key(:condition) 
      expect(json_body[:condition]).to be_a(Hash)
      expect(json_body[:condition]).to have_key(:text)
      expect(json_body[:condition][:text]).to be_a(String)
    end

    it "can return the upcoming weather json framework from the cordinate string", :vcr do
      json_body = @test_facade.upcoming_weather
      
      expect(json_body).to be_an(Array)
      expect(json_body.length).to eq(3)
      expect(json_body[0]).to have_key(:date)
      expect(json_body[0][:date]).to be_a(String)
      expect(json_body[0][:date]).to include("-")
      expect(json_body[0]).to have_key(:sunrise)
      expect(json_body[0][:sunrise]).to be_a(String)
      expect(json_body[0][:sunrise]).to include(" AM")
      expect(json_body[0]).to have_key(:sunset)
      expect(json_body[0][:sunset]).to be_a(String)
      expect(json_body[0][:sunset]).to include(" PM")
      expect(json_body[0]).to have_key(:max_temp)
      expect(json_body[0][:max_temp]).to be_a(Float)
      expect(json_body[0]).to have_key(:min_temp)
      expect(json_body[0][:min_temp]).to be_a(Float)
      expect(json_body[0]).to have_key(:condition)
      expect(json_body[0][:condition]).to be_a(String)
      expect(json_body[0]).to have_key(:icon)
      expect(json_body[0][:icon]).to be_a(String)
      expect(json_body[0][:icon]).to include("//cdn.")
    end

    it "can return the hourly weather json framework from the cordinate string", :vcr do
      json_body = @test_facade.hourly_weather
      
      expect(json_body).to be_an(Array)
      expect(json_body.length).to eq(24)
      expect(json_body[0]).to have_key(:time)
      expect(json_body[0][:time]).to be_a(String)
      expect(json_body[0][:time]).to include(":00")
      expect(json_body[0]).to have_key(:temperature)
      expect(json_body[0][:temperature]).to be_a(Float)
      expect(json_body[0]).to have_key(:conditions)
      expect(json_body[0][:conditions]).to be_a(String)
      expect(json_body[0]).to have_key(:icon)
      expect(json_body[0][:icon]).to be_a(String)
      expect(json_body[0][:icon]).to include("//cdn.")
    end
  end
end