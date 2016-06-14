require 'rails_helper'

RSpec.describe Favourite, type: :model do

  let(:user)      {User.create!(name: "Example User", email: "user@example.com", password: "password")}
  let(:topic)     {Topic.create!(name: Faker::Hipster.sentence, description: Faker::Hipster.paragraph)}
  let(:post)      {topic.posts.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph)}
  let(:favourite) {Favourite.create!(post: post, user: user)}

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

end
