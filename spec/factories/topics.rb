FactoryGirl.define do
  factory :topic do
    name Faker::Name.name
    description Faker::Hipster.paragraph
  end
end