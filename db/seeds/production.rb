email = 'hello@changwoo.org'
unless User.exists?(email: email)
  User.create!({name: 'Nick', username: 'hello1', email: email, password: 'hello1234', password_confirmation: 'hello1234'})
end

admin_email = 'admin@changwoo.org'
unless User.exists?(email: admin_email)
  admin = User.create!({name: 'admin', username: 'admin', email: admin_email, password: 'admin1234', password_confirmation: 'admin1234'})
  admin.admin_roles
end