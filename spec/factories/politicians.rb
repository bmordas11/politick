FactoryGirl.define do
  factory :politician do
    sequence(:first_name) { |n| "R#{n}bert" }
    last_name "Anderson"
    place_of_birth "Random Lake, WI"
    political_party "Republican"
    stance "I am very interested in bridges."
  end
end
