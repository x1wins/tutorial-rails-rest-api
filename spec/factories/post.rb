# spec/factories/user.rb
FactoryGirl.define do
  factory :post do
    body  { Faker::Hacker.say_something_smart }
    user  { create(:user) }
  end
end