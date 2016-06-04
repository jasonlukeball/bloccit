require 'rails_helper'

RSpec.describe Comment, type: :model do

  let (:user)       { User.create!(name: "Example User", email: "user@example.com", password: "password")}
  let (:topic)      { Topic.create!(name: Faker::Hipster.sentence, description: Faker::Hipster.paragraph)}
  let (:post)       { topic.posts.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: user)}
  let (:comment)    { Comment.create!(body: "New Comment Body", post: post, user: user) }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "New Comment Body")
    end
  end

end
