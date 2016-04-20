FactoryGirl.define do
  factory :politician do
    sequence(:first_name) { |n| "R#{n}bert" }
    sequence(:last_name) { |n| "Anderson#{n}" }
    place_of_birth "Random Lake, WI"
    political_party "Republican"
    stance "I am very interested in bridges."
    sequence(:birthday) { |n| "1968-0#{n}-22" }
  end
end
