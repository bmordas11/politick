FactoryGirl.define do
  factory :comment do
    sequence(:title) { |n| "Cool Title #{n}" }
    sequence(:body) { |n| "Cool review body with stuff #{n}." }

    politician
    user
  end
end
