require "rails_helper"

describe ForecastService do
  context "instance methods", :vcr do
    it "can get forecast from coordinates" do
      json_body = ForecastService.new.get_forecast(39.10713,-84.50413)
      expect(json_body).to be_a(Hash)
      expect(json_body).to have_key(:forecast)
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
    end
  end
end