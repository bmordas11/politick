FactoryGirl.define do
  factory :comment do
    sequence(:body) { |n| "Cool review body with stuff #{n}." }
    rating [1, 2, 3, 4, 5].sample

    politician
    user
  end
end
