require "rails_helper"

RSpec.describe MapFacade do
  before :each do
    @test_facade = MapFacade.new("cincinnati,oh")
    @test_facade_2 = MapFacade.new("Cincinnati,OH")
  end

  describe "instance methods" do
    it "has a location" do
      expect(@test_facade.location).to eq("cincinnati,oh")
    end

    it "can return the values of the correct city", :vcr do
      expect(@test_facade.check_city).to eq(true)
    end

    it "can get coordinates from a location", :vcr do
      expect(@test_facade.coordinates).to be_a(Hash)
      expect(@test_facade.coordinates).to have_key(:lat)
      expect(@test_facade.coordinates).to have_key(:lng)
      expect(@test_facade.coordinates[:lat]).to eq(39.10713)
      expect(@test_facade.coordinates[:lng]).to eq(-84.50413)
      expect(@test_facade.coordinates).to eq({:lat=>39.10713, :lng=>-84.50413})
    end

    it "can get directions from an origin and destination", :vcr do
      expect(@test_facade_2.directions("Chicago, IL")).to be_a(Hash)
      expect(@test_facade_2.directions("Chicago, IL")).to have_key(:formattedTime)
      expect(@test_facade_2.directions("Chicago, IL")[:formattedTime]).to be_a(String)
      expect(@test_facade_2.directions("Chicago, IL")).to have_key(:time)
      expect(@test_facade_2.directions("Chicago, IL")[:time]).to be_an(Integer)
    end

    it "can get travel time from an origin and destination", :vcr do
      expect(@test_facade_2.travel_time("Chicago, IL")).to be_a(String)
      expect(@test_facade_2.travel_time("Chicago, IL")).to eq("04:20:07")
    end

    it "can get arrival time from an origin and destination", :vcr do
      expect(@test_facade_2.arrival_time("Chicago, IL")).to be_a(String)
      expect(@test_facade_2.arrival_time("Chicago, IL")).to include("-")
      expect(@test_facade_2.arrival_time("Chicago, IL")).to include(":")
    end
  end
end