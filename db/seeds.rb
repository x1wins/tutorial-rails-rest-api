# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create({username: 'hello', email: 'sample@changwoo.net', password_digest: 'hhhhhhhhh'})
Category.create({title: 'all', body: 'you can talk everything', user_id: user.id})
Category.create({title: 'news', body: 'fastest news in the world', user_id: user.id})