# spec/factories/user.rb
FactoryGirl.define do
  factory :comment do
    body  { Faker::Hacker.say_something_smart }
    user  { create(:user) }
    post  { create(:post) }
  end
end