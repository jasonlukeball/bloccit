require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user)        { create(:user) }
  let(:topic)       { create(:topic) }
  let(:post)        { create(:post, user: user) }
  let(:comment)     { create(:comment) }

  it { should belong_to(:commentable) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: comment.body)
    end
  end


  describe "after create" do

    before do
      @another_comment = Comment.new(body: "Comment body", commentable: post, user: user)
    end

    it "sends an email to users who have favourites the post" do
      expect(FavouriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))
      @another_comment.save!
    end
  end
end