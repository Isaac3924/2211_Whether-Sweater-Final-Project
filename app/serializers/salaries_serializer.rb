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
          salaries: salaries[:salaries].map do |salary|
            if salary[:job][:title] == "Data Analyst" || salary[:job][:title] == "Data Scientist" || salary[:job][:title] == "Mobile Developer" || salary[:job][:title] == "QA Engineer" || salary[:job][:title] == "Software Engineer" || salary[:job][:title] == "Systems Administrator" || salary[:job][:title] == "Web Developer"
              {
                title: salary[:job][:title],
                min: "$" + sprintf('%.2f',salary[:salary_percentiles][:percentile_25] ).gsub(/(\d)(?=(\d{3})+(?!\d))/, '\\1,'),
                max: "$" + sprintf('%.2f',salary[:salary_percentiles][:percentile_75] ).gsub(/(\d)(?=(\d{3})+(?!\d))/, '\\1,')
              }
            end
          end.compact
        }
      }
    }
  end
end
