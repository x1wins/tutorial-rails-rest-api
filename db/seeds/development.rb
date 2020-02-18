require 'factory_bot_rails'

email = 'hello@changwoo.org'
unless User.exists?(email: email)
  User.create!({name: 'Nick', username: 'hello1', email: email, password: 'hello1234', password_confirmation: 'hello1234'})
end

admin_email = 'admin@changwoo.org'
unless User.exists?(email: admin_email)
  admin = User.create!({name: 'admin', username: 'admin', email: admin_email, password: 'admin1234', password_confirmation: 'admin1234'})
  admin.admin_roles
end

user_count = 20
category_count = rand(10..20)
post_count_max = 120
comment_count_max = 300
users = FactoryBot.create_list :user, user_count

threads = []
category_count.times do
  threads << Thread.new do
    category = FactoryBot.create :category, user: admin
    rand(0..post_count_max).times do
      post = FactoryBot.create :post, user: users[rand(0...user_count)], category: category
      rand(0..comment_count_max).times do
        FactoryBot.create :comment, post: post, user: users[rand(0...user_count)]
      end
    end
    ActiveRecord::Base.connection_pool.clear_reloadable_connections!
  end
end

threads.each{|t| t.join}