FactoryGirl.define do
  factory :comment_vote do
    user_vote [true, false].sample

    user
    comment
  end
end
