require "rails_helper"

RSpec.describe "Roadtrip API", type: :request do
  describe "Post /api/v1/road_trip", :vcr do
    let(:valid_attributes1) do
      {
          origin: "Cincinnati,OH",
          destination: "Chicago,IL",
          api_key: "123456789"
      }
    end

    let(:valid_attributes2) do
      {
        origin: "New York, NY",
        destination: "Los Angeles, CA",
        api_key: "987654321"
      }
    end

    let(:valid_attributes3) do
      {
        origin: "New York, NY",
        destination: "Panama City, Panama",
        api_key: "135792468"
      }
    end

    let(:valid_attributes4) do
      {
        origin: "New York, NY",
        destination: "London, UK",
        api_key: "31103110"
      }
    end

    let(:invalid_attributes5) do
      {
        origin: "New York, NY",
        destination: "Denver, CO",
        api_key: "000000000"
      }
    end

    before do
      user1 = User.create!(email: 'email@email.com', password: 'password', password_confirmation: 'password', api_key:"123456789")
      user2 = User.create!(email: 'who@email.com', password: 'password', password_confirmation: 'password', api_key:"987654321")
      user3 = User.create!(email: 'whatl@email.com', password: 'password', password_confirmation: 'password', api_key:"135792468")
      user4 = User.create!(email: 'when@email.com', password: 'password', password_confirmation: 'password', api_key:"31103110")
    end

    context "request 1" do
      before { get "/api/v1/road_trip", params: valid_attributes1, as: :json }

      it "is a json" do
        pretty = JSON.parse(response.body)

        expect(pretty).to be_a(Hash)
      end

      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns road trip data as requested" do
        pretty = JSON.parse(response.body)
        expect(pretty["data"]["attributes"].keys.length).to eq(4)
        expect(pretty["data"]["attributes"].keys).to eq(["start_city", "end_city", "travel_time", "weather_at_eta"])
        expect(pretty["data"]["attributes"]["start_city"]).to eq("Cincinnati,OH")
        expect(pretty["data"]["attributes"]["end_city"]).to eq("Chicago,IL")
        expect(pretty["data"]["attributes"]["travel_time"]).to include(":")
        expect(pretty["data"]["attributes"]["weather_at_eta"].keys.length).to eq(3)
        expect(pretty["data"]["attributes"]["weather_at_eta"].keys).to eq(["date_time", "temperature", "condition"])
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to be_a(String)
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to include("-")
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to include(":00")
        expect(pretty["data"]["attributes"]["weather_at_eta"]["temperature"]).to be_a(Float)
        expect(pretty["data"]["attributes"]["weather_at_eta"]["condition"]).to be_a(String)
      end
    end

    context "request 2" do
      before { get "/api/v1/road_trip", params: valid_attributes2, as: :json }

      it "is a json" do
        pretty = JSON.parse(response.body)

        expect(pretty).to be_a(Hash)
      end

      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns road trip data as requested" do
        pretty = JSON.parse(response.body)
        expect(pretty["data"]["attributes"].keys.length).to eq(4)
        expect(pretty["data"]["attributes"].keys).to eq(["start_city", "end_city", "travel_time", "weather_at_eta"])
        expect(pretty["data"]["attributes"]["start_city"]).to eq("New York, NY")
        expect(pretty["data"]["attributes"]["end_city"]).to eq("Los Angeles, CA")
        expect(pretty["data"]["attributes"]["travel_time"]).to include(":")
        expect(pretty["data"]["attributes"]["travel_time"][0..1].to_i).to eq(38)
        expect(pretty["data"]["attributes"]["weather_at_eta"].keys.length).to eq(3)
        expect(pretty["data"]["attributes"]["weather_at_eta"].keys).to eq(["date_time", "temperature", "condition"])
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to be_a(String)
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to include("-")
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to include(":00")
        expect(pretty["data"]["attributes"]["weather_at_eta"]["temperature"]).to be_a(Float)
        expect(pretty["data"]["attributes"]["weather_at_eta"]["condition"]).to be_a(String)
      end
    end

    context "request 3" do
      before { get "/api/v1/road_trip", params: valid_attributes3, as: :json }

      it "is a json" do
        pretty = JSON.parse(response.body)

        expect(pretty).to be_a(Hash)
      end

      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns road trip data as requested" do
        pretty = JSON.parse(response.body)
        expect(pretty["data"]["attributes"].keys.length).to eq(4)
        expect(pretty["data"]["attributes"].keys).to eq(["start_city", "end_city", "travel_time", "weather_at_eta"])
        expect(pretty["data"]["attributes"]["start_city"]).to eq("New York, NY")
        expect(pretty["data"]["attributes"]["end_city"]).to eq("Panama City, Panama")
        expect(pretty["data"]["attributes"]["travel_time"]).to include(":")
        expect(pretty["data"]["attributes"]["travel_time"][0..1].to_i).to eq(76)
        expect(pretty["data"]["attributes"]["weather_at_eta"].keys.length).to eq(3)
        expect(pretty["data"]["attributes"]["weather_at_eta"].keys).to eq(["date_time", "temperature", "condition"])
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to be_a(String)
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to include("-")
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to include(":00")
        expect(pretty["data"]["attributes"]["weather_at_eta"]["temperature"]).to be_a(String)
        expect(pretty["data"]["attributes"]["weather_at_eta"]["temperature"]).to eq("Trip too long. Cannot retrieve forecast.")
        expect(pretty["data"]["attributes"]["weather_at_eta"]["condition"]).to be_a(String)
      end
    end

    context "request 4" do
      before { get "/api/v1/road_trip", params: valid_attributes4, as: :json }

      it "is a json" do
        pretty = JSON.parse(response.body)

        expect(pretty).to be_a(Hash)
      end

      it "returns a 200 status code" do
        expect(response).to have_http_status(200)
      end

      it "returns road trip data as requested" do
        pretty = JSON.parse(response.body)
        expect(pretty["data"]["attributes"].keys.length).to eq(4)
        expect(pretty["data"]["attributes"].keys).to eq(["start_city", "end_city", "travel_time", "weather_at_eta"])
        expect(pretty["data"]["attributes"]["start_city"]).to eq("New York, NY")
        expect(pretty["data"]["attributes"]["end_city"]).to eq("London, UK")
        expect(pretty["data"]["attributes"]["travel_time"]).to eq("impossible")
        expect(pretty["data"]["attributes"]["weather_at_eta"].keys.length).to eq(3)
        expect(pretty["data"]["attributes"]["weather_at_eta"].keys).to eq(["date_time", "temperature", "condition"])
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to be_a(String)
        expect(pretty["data"]["attributes"]["weather_at_eta"]["date_time"]).to eq("N/A")
        expect(pretty["data"]["attributes"]["weather_at_eta"]["temperature"]).to eq("")
        expect(pretty["data"]["attributes"]["weather_at_eta"]["condition"]).to eq("")
      end
    end

    context "request 5" do
      before { get "/api/v1/road_trip", params: invalid_attributes5, as: :json }

      it "is a json" do
        pretty = JSON.parse(response.body)

        expect(pretty).to be_a(Hash)
      end

      it "returns a 401 status code" do
        expect(response).to have_http_status(401)
        expect(response).to have_http_status(:unauthorized)
      end

      it "returns road trip data as requested" do
        pretty = JSON.parse(response.body)
        expect(pretty.keys.length).to eq(1)
        expect(pretty.keys).to eq(["error"])
        expect(pretty["error"]).to eq("Unauthorized")
      end
    end
  end
end