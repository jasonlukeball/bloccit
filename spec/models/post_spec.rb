require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:topic_name)          { Faker::Hipster.sentence }
  let(:topic_description)   { Faker::Hipster.paragraph }
  let(:post_title)          { Faker::Hipster.sentence }
  let(:post_body)           { Faker::Hipster.paragraph }

  let(:topic)               { Topic.create!(name: topic_name, description: topic_description) }
  let(:user)                { User.create!(name: "Example User", email: "user@example.com", password: "password")}
  let(:post)                { topic.posts.create!(title: post_title, body: post_body, user: user) }
  let(:post2)                { topic.posts.create!(title: post_title, body: post_body, user: user) }

  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favourites) }


  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :topic }
  it { is_expected.to validate_presence_of :user }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }



  describe "attributes" do
    it "has the title, body and user attributes" do
      expect(post).to have_attributes(title: post_title, body: post_body, user: user)
    end
  end


  describe "voting" do

    before do
      3.times { post.votes.create!(value: 1) }
      2.times { post.votes.create!(value: -1) }
      @up_votes = post.votes.where(value: 1).count
      @down_votes = post.votes.where(value: -1).count
    end

    describe "#up_votes" do
      it "counts the number of votes where value is equal to 1" do
        expect(post.up_votes).to eq(@up_votes)
      end
    end

    describe "#down_votes" do
      it "counts the number of votes where value is equal to -1" do
        expect(post.down_votes).to eq(@down_votes)
      end
    end

    describe "#points" do
      it "returns the sum of all down and up votes" do
        expect(post.points).to eq(@up_votes - @down_votes)
      end
    end

  end


  describe "#update_rank" do

    it "calculates the correct rank" do
      post.update_rank
      expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970,1,1)) / 1.day.seconds)
    end

    it "updates the rank when an up vote is created" do
      old_rank = post2.rank.round(0)
      post2.votes.create!(value: 1)
      expect(post.rank.round(0)).to eq(old_rank)
    end

    it "updates the rank when a down vote is created" do
      old_rank = post2.rank.round(0)
      post2.votes.create!(value: -1)
      expect(post.rank.round(0)).to eq(old_rank)
    end
  end


  describe "create vote" do

    it "adds an up_vote by the current_user for new posts" do
      expect(post.up_votes).to eq 1
    end

    it "calls #create_vote when a post is created" do
      post = topic.posts.new(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: user)
      expect(post).to receive(:create_vote)
      post.save
    end

    it "the post's first vote belongs to the owner of the post" do
      expect(post.votes.first.user).to eq(user)
    end

  end


  describe "create favourite" do
    it "calls the #create_favourite method when a post is created" do
      post = topic.posts.new(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: user)
      expect(post).to receive(:create_favourite)
      post.save
    end

  end


end
