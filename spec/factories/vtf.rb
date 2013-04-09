FactoryGirl.define do
  sequence :email do |e|
    "test-guy-#{e}@testmail.com"
  end

  sequence :password do |e|
    "verysecret-#{e}"
  end

  factory :user do
    email
    password
  end
end
