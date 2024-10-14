require "rails_helper"

RSpec.describe "Forecast API", type: :request do
  describe "GET /api/v1/forecast?location=cincinatti,oh", :vcr do
    let(:valid_location) do
      { location: "cincinnati,oh" }
    end
    context "when the request is valid" do
      before { get "/api/v1/forecast", params: valid_location }

      it "is a json" do
        # binding.pry
        expect(JSON.parse(response.body)).to be_a(Hash)
      end

      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a forecast" do
        expect(JSON.parse(response.body)["data"]["attributes"]["current_weather"]).to be_a(Hash)
        expect(JSON.parse(response.body)["data"]["attributes"]["daily_weather"]).to be_an(Array)
        expect(JSON.parse(response.body)["data"]["attributes"]["hourly_weather"]).to be_an(Array)
      end

      it "returns a forecast with the correct attributes" do
        expect(JSON.parse(response.body)["data"]["attributes"]["current_weather"].keys).to eq(["last_updated", "temperature", "feels_like", "humidity", "uvi", "visibility", "condition", "icon"])
        expect(JSON.parse(response.body)["data"]["attributes"]["daily_weather"].first.keys).to eq(["date", "sunrise", "sunset", "max_temp", "min_temp", "condition", "icon"])
        expect(JSON.parse(response.body)["data"]["attributes"]["hourly_weather"].first.keys).to eq(["time", "temperature", "conditions", "icon"])
        expect(JSON.parse(response.body)["data"]["attributes"]["hourly_weather"].first["time"].length).to eq(5)
        expect(JSON.parse(response.body)["data"]["attributes"]["hourly_weather"].first["time"]).to include(":")

      end

      it "does not hold extraneous data" do
        expect(JSON.parse(response.body)["data"]["attributes"]["current_weather"].keys.length).to eq(8)
        expect(JSON.parse(response.body)["data"]["attributes"]["daily_weather"].first.keys.length).to eq(7)
        expect(JSON.parse(response.body)["data"]["attributes"]["hourly_weather"].first.keys.length).to eq(4)
        expect(JSON.parse(response.body)["data"]["attributes"].keys.length).to eq(3)
        expect(JSON.parse(response.body)["data"].keys.length).to eq(3)
        expect(JSON.parse(response.body).keys.length).to eq(1)
        expect(JSON.parse(response.body)["data"]["attributes"]["current_weather"].keys).to_not include("last_updated_epoch", "temp_c", "feelslike_c", "is_day", "wind_kph", "wind_degree", "wind_mph", "pressure_in", "precip_mm", "gust_kph", "vis_km")
        expect(JSON.parse(response.body)["data"]["attributes"]["daily_weather"].first.keys).to_not include("avgtemp_f", "avgtemp_c", "maxwind_mph", "maxwind_kph", "totalprecip_in", "totalprecip_mm", "avgvis_miles", "avgvis_km", "avghumidity", "daily_will_it_rain", "daily_chance_of_rain", "daily_will_it_snow", "daily_chance_of_snow", "uv")
        expect(JSON.parse(response.body)["data"]["attributes"]["hourly_weather"].first.keys).to_not include("temp_c", "feelslike_f", "feelslike_c", "wind_mph", "wind_kph", "wind_degree", "wind_dir", "pressure_in", "precip_mm", "precip_in", "humidity", "cloud", "feelslike_f", "feelslike_c", "windchill_f", "windchill_c", "heatindex_f", "heatindex_c", "dewpoint_f", "dewpoint_c", "will_it_rain", "chance_of_rain", "will_it_snow", "chance_of_snow", "vis_km", "vis_miles", "gust_mph", "gust_kph", "uv")
      end
    end
  end
end