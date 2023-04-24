require "rails_helper"

RSpec.describe "Salaries API", type: :request do
  describe "GET /api/v1/salaries?destination=chicago", :vcr do
    # let(:valid_location) do
    #   { location: "chicago" }
    # end
    context "when the request is valid" do
      # before { get "/api/v1/salaries", params: valid_location }
      before { get "/api/v1/salaries?destination=chicago" }


      it "is a json" do
        expect(JSON.parse(response.body)).to be_a(Hash)
      end

      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns a destination" do
        expect(JSON.parse(response.body)["data"]["attributes"]["destination"]).to eq("chicago")
      end

      it "returns a forecast" do
        expect(JSON.parse(response.body)["data"]["attributes"]["forecast"]).to be_a(Hash)
        expect(JSON.parse(response.body)["data"]["attributes"]["forecast"].keys).to eq(["summary", "temperature"])
        expect(JSON.parse(response.body)["data"]["attributes"]["forecast"]["summary"]).to be_a(String)
        expect(JSON.parse(response.body)["data"]["attributes"]["forecast"]["temperature"]).to be_a(String)
        expect(JSON.parse(response.body)["data"]["attributes"]["forecast"]["temperature"]).to_not include(".")
        expect(JSON.parse(response.body)["data"]["attributes"]["forecast"]["temperature"]).to include(" F")
      end

      it "returns salaries" do
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"]).to be_a(Array)
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].length).to eq(7)
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first.keys).to eq(["title", "min", "max"])
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first["title"]).to be_a(String)
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first["title"]).to eq("Data Analyst")
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first["min"]).to be_a(String)
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first["max"]).to be_a(String)
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first["min"]).to include("$")
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first["max"]).to include("$")
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first["min"]).to include(".")
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first["max"]).to include(".")
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first["min"]).to include(",")
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first["max"]).to include(",")
      end

      it "does not hold extraneous data" do
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first.keys).to_not include("id")
        expect(JSON.parse(response.body)["data"]["attributes"]["salaries"].first.keys.length).to eq(3)
        expect(JSON.parse(response.body)["data"]["attributes"]["forecast"].keys.length).to eq(2)
        expect(JSON.parse(response.body)["data"]["attributes"].keys.length).to eq(3)
        expect(JSON.parse(response.body)["data"].keys.length).to eq(3)
        expect(JSON.parse(response.body).keys.length).to eq(1)
        expect(JSON.parse(response.body)["data"]["attributes"]["forecast"].keys).to_not include("last_updated_epoch", "temp_c", "feelslike_c", "is_day", "wind_kph", "wind_degree", "wind_mph", "pressure_in", "precip_mm", "gust_kph", "vis_km")
      end
    end
  end
end