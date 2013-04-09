FactoryGirl.define do
  sequence :email do |n|
    "test-email-#{n}@testmail.com"
  end

  factory :user do
    email
    password "verysecret"
  end

  factory :category do
    name "XSS"
  end

  factory :exercise do
    category
    sequence(:name) { |n| "Exercise ##{n}" }
    description { "Description for #{name}" }
  end
end
