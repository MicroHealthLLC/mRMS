require 'faker'

FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password {Faker::Internet.password}
    admin = true
    state = :active
    login { Faker::Name.first_name }
  end

end
