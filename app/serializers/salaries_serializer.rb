class SalariesSerializer
  include JSONAPI::Serializer

  def self.format_salaries(destination, salaries, forecast)
    {
      data: 
      {
        id: nil,
        type: "salaries",
        attributes: 
        {
          destination: destination,
          forecast: 
          {
            summary: forecast[:current][:condition][:text],
            temperature: forecast[:current][:temp_f].round.to_s + " F"
          },
          salaries: salaries.map do |salary|
           {
            if salary[:job][:title].eq "Data Analyst" 
              job_title: salary[:job][:title],
              min: "$"salary[:salary_percentiles][:percentile_25].round.to_s,
            end
           }
        }
      }
    }
  end
end
