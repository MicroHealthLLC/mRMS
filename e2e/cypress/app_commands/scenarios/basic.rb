# You can setup your Rails state here
# MyModel.create name: 'something'
user = User.find_or_initialize_by(email: 'admin@test.com')
user.admin = true
user.state = true
user.password = 'T3$tAdmin'
user.login = 'admin'
user.save(validate: false)

user = User.find_or_initialize_by(email: 'client@test.com')
user.admin = false
user.state = true
user.password = 'T3$tClient'
user.login = 'client'
user.save(validate: false)

content = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'

Setting.find_or_create_by(setting_type: 'section_1', value: content)
Setting.find_or_create_by(setting_type: 'section_2', value: content)
Setting.find_or_create_by(setting_type: 'section_3', value: content)
Setting.find_or_create_by(setting_type: 'section_4', value: content)
