require 'csv'

CSV.open('politician_names.csv', 'w') {}
CSV.open('politician_info.csv', 'w') {}

Politician.create!(
  first_name: 'Donald',
  last_name: 'Trump',
  political_party: 'Republican',
  place_of_birth: 'Queens, NY, U.S.',
  birthday: '1946-06-14'
)

PoliticianGetter.scraper

politician_name_list = []
CSV.foreach("politician_names.csv") do |row|
  politician_name_list << row
end
politician_name_list.map! { |politician| politician[0] }
BLACKLIST = [
  "abdul-jabbar",
  "wisconsin-legislature-republicans",
  "wisconsin-assembly-republicans",
  "university-wisconsin-madison",
  "us-senate-democrats",
  "van-taylor",
  "danny-tarkanian",
  "brian-stelter",
  "state-department",
  "kathryn-starkey",
  "social-media",
  "national-senate-republicans",
  "phil-robertson",
  "robert-puente",
  "public-employee-unions",
  "politifact-sheets",
  "philadelphia-daily-news",
  "oregon-public-employees-retirement-system",
  "oregon-ballot-measure-81",
  "north-korea",
  "national-football-league",
  "steve-montenegro",
  "milwaukee-metropolitan-sewerage-district",
  "milwaukee-county-sheriffs-office",
  "john-mccain",
  "wendy-long",
  "vernon-keenan",
  "johnson-controls",
  "national-house-republicans",
  "john-holdren",
  "bill-heller",
  "terry-gorman",
  "hud",
  "florida-supreme-court",
  "pat-carlson",
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
