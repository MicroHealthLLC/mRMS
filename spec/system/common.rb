
def user_create
  User.create(login: Faker::Name.name,email: Faker::Internet.email,password:Faker::Internet.password(mix_case: true), state: "active")
end

def admin_create
  User.create(login: Faker::Name.name,email: Faker::Internet.email,password:Faker::Internet.password(mix_case: true), state: "active", admin: true)
end

def content_values
  {header:Faker::Name.name,section_1:Faker::Name.name, section_2:Faker::Name.name,section_3:Faker::Name.name,section_4:Faker::Name.name}
end

def login_user(login_name, password)
  visit '/users/sign_in'
  within("#login-form") do
    fill_in 'user_login', with: login_name
    fill_in 'user_password', with: password
  end
  click_button 'Sign in'
end
