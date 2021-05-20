# You can setup your Rails state here
# MyModel.create name: 'something'
  user = User.find_or_initialize_by(email: 'admin@test.com')
  user.admin = true
  user.state = true
  user.password = 'T3$tAdmin'
  user.login = 'admin'
  user.save(validate: false)
