require 'rails_helper'

feature 'scraper works when called' do
  let!(:scraped) { PoliticianGetter.scraper }
  let!(:info_cleaner) { CSV.open('politician_info.csv', 'w') {} }
  let!(:politician_name_list) { [] }

  scenario 'politician getter will give list of politician links' do
    CSV.foreach("politician_names.csv") do |row|
      politician_name_list << row
    end
    politician_name_list.map! { |politician| politician[0] }

    has_hillary = politician_name_list.include? "hillary-clinton"
    has_bernie = politician_name_list.include? "bernie-s"
    expect(has_hillary).to be true
    expect(has_bernie).to be true
    CSV.open('politician_info.csv', 'w') {}
    CSV.open('politician_names.csv', 'w') {}
  end

  scenario 'politifact scraper will give data about politicians' do
    politician_name_list << "nickie-antonio"
    PolitifactScraper.scrape(politician_name_list)

    CSV.foreach("politician_info.csv") do |row|
      politician = Politician.new(stance: row[4])
      expect(politician.stance).
        to have_content "Nickie J. Antonio is a state representative"
    end
    CSV.open('politician_info.csv', 'w') {}
    CSV.open('politician_names.csv', 'w') {}
  end
end
