# spec/factories/user.rb
FactoryBot.define do
  factory :post do
    body  { Faker::Hacker.say_something_smart }
    user  { create(:user) }
    category  { create(:category) }
  end
end