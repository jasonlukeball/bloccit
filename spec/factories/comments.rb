FactoryBot.define do
  factory :comment do
    body { Faker::Hipster.sentence }
    association :commentable, factory: :user
    user
  end
end