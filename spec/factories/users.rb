FactoryGirl.define do
  password = Faker::Internet.password(8)

  factory :user do
    name Faker::Name.name
    sequence(:email){|n| "user#{n}@factory.com" }
    password password
    password_confirmation password
    role :member
  end
end

