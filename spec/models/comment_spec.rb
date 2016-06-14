require 'rails_helper'

RSpec.describe Comment, type: :model do

  let (:user)       { User.create!(name: "Example User", email: "user@example.com", password: "password")}
  let (:topic)      { Topic.create!(name: Faker::Hipster.sentence, description: Faker::Hipster.paragraph)}
  let (:post)       { topic.posts.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: user)}
  let (:comment)    { Comment.create!(body: "New Comment Body", commentable: post, user: user) }

  it { should belong_to(:commentable) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "New Comment Body")
    end
  end


  describe "after create" do

    before do
      @another_comment = Comment.new(body: "Comment body", commentable: post, user: user)
    end

    it "sends an email to users who have favourites the post" do
      favourite = user.favourites.create(post: post)
      expect(FavouriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))
      @another_comment.save!
    end

    it "does not send emails to users who have not favourites the post" do
      expect(FavouriteMailer).not_to receive(:new_comment)
      @another_comment.save!
    end

  end

end