FactoryBot.define do
  factory :category do
    title { Faker::Ancient.god }
    body { Faker::Hacker.say_something_smart }
    user { create(:user) }
    published { true }
  end
end
