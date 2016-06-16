FactoryGirl.define do
  factory :comment do
    body Faker::Hipster.sentence
    user
    association :commentable, factory: :post  # required for the polymorphic association
  end
end

