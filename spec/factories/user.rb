FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.name }
    email { Faker::Internet.unique.email }
    password_digest { Faker::Alphanumeric.alpha(number: 15) }
    api_key { "MyString" }
  end
end