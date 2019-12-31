# spec/factories/user.rb
FactoryGirl.define do
  factory :comment do
    body  { Faker::Hacker.say_something_smart }
    user_id  { user.id }
    post_id  { post.id }
  end
end