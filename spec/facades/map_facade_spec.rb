require "rails_helper"

RSpec.describe MapFacade do
  before :each do
    @test_facade = MapFacade.new("cinncinati,oh")
  end

  describe "instance methods" do
    it "has a location" do
      expect(@test_facade.location).to eq("cinncinati,oh")
    end

    it "can get coordinates from a location", :vcr do
      expect(@test_facade.coordinates).to be_a(Hash)
      expect(@test_facade.coordinates).to have_key(:lat)
      expect(@test_facade.coordinates).to have_key(:lng)
      expect(@test_facade.coordinates[:lat]).to eq(39.10713)
      expect(@test_facade.coordinates[:lng]).to eq(-84.50413)
      expect(@test_facade.coordinates).to eq({:lat=>39.10713, :lng=>-84.50413})
    end
  end
end