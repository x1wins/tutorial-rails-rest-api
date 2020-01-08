FactoryBot.define do
  factory :category do
    title { "MyString" }
    body { "MyString" }
    user { nil }
    published { false }
  end
end
