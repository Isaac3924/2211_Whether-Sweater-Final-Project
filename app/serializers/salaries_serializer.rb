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
            if salary[:job][:title] == "Data Analyst" || salary[:job][:title] == "Data Scientist" || salary[:job][:title] == "Mobile Developer" || salary[:job][:title] == "QA Engineer" || salary[:job][:title] == "Software Engineer" || salary[:job][:title] == "Systems Administratot" || salary[:job][:title] == "Web Developer"
              job_title: salary[:job][:title],
              min: "$"salary[:salary_percentiles][:percentile_25].sprintf('%.2f').gsub(/(\d)(?=(\d{3})+(?!\d))/, '\\1,'),
              max: "$"salary[:salary_percentiles][:percentile_75].sprintf('%.2f').gsub(/(\d)(?=(\d{3})+(?!\d))/, '\\1,')
            end
           }
          end
        }
      }
    }
  end
end
