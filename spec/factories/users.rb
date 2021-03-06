FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name 'John'
    last_name 'Smith'
    password 'password'
    password_confirmation 'password'
    role 'member'
  end

  factory :admin, class: User do
    sequence(:email) { |n| "admin#{n}@pantparty.com" }
    first_name 'John'
    last_name 'Smith'
    password 'password'
    password_confirmation 'password'
    role 'admin'
  end
end
