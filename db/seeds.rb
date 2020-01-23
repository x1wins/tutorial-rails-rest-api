# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

email = 'hello@changwoo.org'
unless User.where(email: email)
  User.create!({username: 'hello1', email: 'hello@changwoo.org', password: 'hello1234', password_confirmation: 'hello1234'})
end

admin = FactoryBot.create :admin
user_count = rand(1..20)
category_count = rand(1..10)
post_count = rand(1..20)
comment_count = rand(1..100)
users = FactoryBot.create_list :user, user_count
category_count.times do
  category = FactoryBot.create :category, user: admin
  post_count.times do
    post = FactoryBot.create :post, user: users[rand(0...user_count)], category: category
    comment_count.times do
      FactoryBot.create :comment, post: post, user: users[rand(0...user_count)]
    end
  end
end
