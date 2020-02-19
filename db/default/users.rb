data = [
  { email: 'admin@localhost.com', password: '123qwe', role_user: 'admin'}
]

data.each do |datum|
  unless User.find_by(email: datum[:email])
    User.create!(datum)
  end
end
