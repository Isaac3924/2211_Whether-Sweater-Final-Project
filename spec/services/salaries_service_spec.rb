require "rails_helper"

describe SalariesService do
  context "instance methods", :vcr do
    it "can get job min and max slaries of jobs of urban area" do
      json_body = SalariesService.new.get_jobs("chicago")

      expect(json_body).to be_a(Hash)
      expect(json_body).to have_key(:salaries)
      expect(json_body[:salaries]).to be_an(Array)
      expect(json_body[:salaries][0]).to be_a(Hash)
      expect(json_body[:salaries][1]).to have_key(:job)
      expect(json_body[:salaries][2][:job]).to be_a(Hash)
      expect(json_body[:salaries][3][:job]).to have_key(:title)
      expect(json_body[:salaries][4][:job][:title]).to be_a(String)
      expect(json_body[:salaries][5]).to have_key(:salary_percentiles)
      expect(json_body[:salaries][6][:salary_percentiles]).to be_a(Hash)
      expect(json_body[:salaries][7][:salary_percentiles]).to have_key(:percentile_25)
      expect(json_body[:salaries][8][:salary_percentiles]).to have_key(:percentile_75)
      expect(json_body[:salaries][9][:salary_percentiles][:percentile_25]).to be_a(Float)
      expect(json_body[:salaries][10][:salary_percentiles][:percentile_75]).to be_a(Float)
    end
  end
end