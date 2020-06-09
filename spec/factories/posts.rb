FactoryBot.define do
  factory :post do
    title { Faker::Hipster.sentence }
    body { Faker::Hipster.paragraph }
    topic
    user
    rank { 0.0 }
  end
end