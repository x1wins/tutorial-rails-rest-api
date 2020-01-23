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

10.times do
  category = FactoryBot.create :category, user: admin
  30.times do
    user = FactoryBot.create :user
    post = FactoryBot.create :post, user: user, category: category
    30.times do
      FactoryBot.create :comment, post: post
    end
  end
end
