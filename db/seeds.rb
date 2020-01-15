# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!({username: 'hello', email: 'sample@changwoo.net', password: 'hhhhhhhhh', password_confirmation: 'hhhhhhhhh'})
user2 = User.create!({username: 'hello1', email: 'hello@changwoo.org', password: 'hello1234', password_confirmation: 'hello1234'})

category = Category.create!({title: 'all', body: 'you can talk everything', user_id: user.id})
posts = Post.where(category_id: nil).or(Post.where(published: nil))
posts.each do |post|
  post.category_id = category.id
  post.published = true
  post.save
  p post
end
p category
