require "rails_helper"

describe MapService do
  context "instance methods", :vcr do
    it "can get coordinates from a location" do
      json_body = MapService.new.get_coordinates("cinncinati,oh")
      expect(json_body).to be_a(Hash)
      expect(json_body).to have_key(:results)
      expect(json_body[:results]).to be_an(Array)
      expect(json_body[:results][0]).to have_key(:locations)
      expect(json_body[:results][0][:locations]).to be_an(Array)
      expect(json_body[:results][0][:locations][0]).to have_key(:latLng)
      expect(json_body[:results][0][:locations][0][:latLng]).to be_a(Hash)
      expect(json_body[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(json_body[:results][0][:locations][0][:latLng]).to have_key(:lng)
      expect(json_body[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
      expect(json_body[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
    end

    it "can get directions from an origin and destination" do
      json_body = MapService.new.get_directions("Cincinnati, OH", "Chicago, IL")
      expect(json_body).to have_key(:route)
      expect(json_body[:route]).to be_a(Hash)
      expect(json_body[:route]).to have_key(:formattedTime)
      expect(json_body[:route][:formattedTime]).to be_a(String)
      expect(json_body[:route]).to have_key(:time)
      expect(json_body[:route][:time]).to be_an(Integer)
    end
  end
end