# spec/factories/user.rb
FactoryBot.define do
  factory :user do
    name    { Faker::Name.first_name }
    username    { Faker::Name.unique.last_name }
    email    { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    trait :admin do
      after(:create) { |user| user.admin_roles }
    end
    factory :admin, traits: [:admin]
  end
end