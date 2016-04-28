class PoliticianGetter < ActiveRecord::Base
  # Each .csv of politicians is saved to politician_names.csv
  require 'nokogiri'
  require 'open-uri'
  require 'pry'
  require 'csv'

  def self.scrape_politician_data()
    url = "http://www.politifact.com/personalities"
    parsed_page = Nokogiri::HTML(open(url))
    links = parsed_page.css("a.link")
    all_links = []

    links.each do |link|
      puts link.attributes['href'].value
      url = link.attributes['href'].value
      url_array = url.split('/')
      all_links << url_array[2]
    end

    all_links
  end

  def self.scraper()
    counter = 0
    puts "Opening: http://www.politifact.com/personalities/"

    puts "Scraping politician links"
    politician_links = PoliticianGetter.scrape_politician_data()
    puts "Stashing #{politician_links.length} links into array"

    # save gathered info to a csv
    politician_links.each do |link|
      CSV.open("politician_names.csv", "ab") do |csv|
        csv << [
          link
        ]
        counter += 1
      end
    end
    politician_links.clear
    puts "politician_names.csv saved with #{counter} lines"
  end
end
