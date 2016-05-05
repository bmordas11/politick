require 'csv'

PoliticianGetter.scraper

politician_name_list = []
CSV.foreach("politician_names.csv") do |row|
  politician_name_list << row
end
politician_name_list.map! { |politician| politician[0] }
BLACKLIST = [
  "paul-farrow",
  "doug-ducey",
  "diane-douglas",
  "paul-doughty",
  "arizona-grassroots-action-pac",
  "billboard-spaghetti-junction",
  "democracy-america",
  "jeff-dewit",
  "michael-m-crow",
  "nextgen-climate",
  "cleantv",
  "cargillmug",
  "joe-arpaio",
  "aclu-new-jersey-aclu",
  "my-city-bikes",
  "60-plus-association",
  "18-percent-american-public"
].map!(&:freeze).freeze
politician_name_list -= BLACKLIST
politician_name_list.uniq!
PolitifactScraper.scrape(politician_name_list)

Politician.create(
  first_name: 'Bernard',
  last_name: 'Sanders',
  political_party: 'Democrat',
  place_of_birth: 'Brooklyn, NY, U.S.',
  birthday: '1941-09-08'
)
Politician.create(
  first_name: 'Donald',
  last_name: 'Trump',
  political_party: 'Republican',
  place_of_birth: 'Queens, NY, U.S.',
  birthday: '1946-06-14'
)
Politician.create(
  first_name: 'Hillary',
  last_name: 'Clinton',
  political_party: 'Democrat',
  place_of_birth: 'Chicago, IL, U.S.',
  birthday: '1947-10-26'
)

CSV.foreach("politician_info.csv") do |row|
  new_politician = Politician.new(first_name: row[0], last_name: row[1])
  new_politician.political_party = row[2]
  if !new_politician.stance.nil?
    new_politician.stance = row[4]
  else
    new_politician.stance = "(No stance given)"
  end
  if new_politician.save
    puts "Successfully added #{row[0]}"
  else
    puts "Could not save #{row[0]} to the database."
  end
end

CSV.open('politician_names.csv', 'w') {}
CSV.open('politician_info.csv', 'w') {}
