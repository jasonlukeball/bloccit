require 'rails_helper'

RSpec.describe Comment, type: :model do

  let (:topic)      { Topic.create!(name: Faker::Hipster.sentence, description: Faker::Hipster.paragraph)}
  let (:post)       { topic.posts.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph)}
  let (:comment)    { Comment.create!(body: "New Comment Body", post: post) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "New Comment Body")
    end
  end

end
