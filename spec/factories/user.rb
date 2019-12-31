# spec/factories/user.rb
FactoryGirl.define do
  factory :user do
    name    { Faker::Name.name }
    username    { name }
    email    { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end