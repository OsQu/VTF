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

    factory :category_with_exercises do
      ignore do
        exercise_count 3
      end

      after(:create) do |category, evaluator|
        category.exercises << FactoryGirl.create_list(:exercise, evaluator.exercise_count)
      end
    end
  end

  factory :exercise do
    sequence(:name) { |n| "Exercise ##{n}" }
    description { "Description for #{name}" }
    parameterized_name "exercise"
  end
end
