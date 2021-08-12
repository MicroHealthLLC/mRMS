require 'faker'

FactoryBot.define do

  factory :admin do
    email {"admin@gmail.com"}
    password {Faker::Internet.password}
    admin = true
    state = :active
    login { Faker::Name.first_name }
  end

  factory :user do
    email {"admin@gmail.com"}
    password {Faker::Internet.password}
    admin = true
    state = :active
    login { Faker::Name.first_name }
  end
end
