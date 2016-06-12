class PolitifactScraper < ActiveRecord::Base
  def self.scrape(name_list)
    counter = 0
    name_list.each do |politician|
      politicians_info = []

      # Open the specified product page, throw it into a Nokogiri object
      puts "Opening: http://www.politifact.com/personalities/#{politician}/"
      puts "Scraping '#{politician}'"
      politicians_info << PolitifactScraper.scrape_politician_data(politician)
      puts "Stashing #{politicians_info.last.first_name} in array"

      politicians_info.each do |the_politician|
        CSV.open("politician_info.csv", "ab") do |csv|
          csv << [
            the_politician.first_name,
            the_politician.last_name,
            the_politician.political_party,
            the_politician.url,
            the_politician.stance
          ]
          counter += 1
        end
      end
      politicians_info.clear

      puts "stuff.csv saved with #{counter} lines"
    end
  end

  def self.scrape_politician_data(url_fragment)
    url = "http://www.politifact.com/personalities/#{url_fragment}/"
    parsed_page = Nokogiri::HTML(open(url))

    # stuff all our data into a politician object
    politician = PoliticianScraped.new

    politician.url = url
    name = parsed_page.css("title").children.text.split[0..1].join ' '
    politician.first_name = name.split[0]
    politician.last_name = name.split[1].gsub("'s", "")

    politician.political_party = parsed_page.css("h3.scorecard__title")
      .text.split[0]
    politician.stance = parsed_page.css("div .scorecard__bio-text").text.strip

    politician
  end

  class PoliticianScraped
    attr_accessor :url, :first_name, :last_name, :political_party
    attr_accessor :stance
  end
end
