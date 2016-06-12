require 'rails_helper'

RSpec.describe Vote, type: :model do


  let(:topic)   {Topic.create!(name: Faker::Hipster.sentence, description: Faker::Hipster.paragraph)}
  let(:user)    {User.create!(name: "Example User", email: "user@example.com", password: "password")}
  let(:post)    {topic.posts.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: user)}
  let(:vote)    {Vote.create!(value: 1, post: post, user: user)}

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_inclusion_of(:value).in_array([-1, 1]) } #validate that vote value is either -1 or 1

  describe "update_post callback" do

    it "triggers update_post on save" do
      expect(vote).to receive(:update_post).at_least(:once)
      vote.save!
    end

    it "#update_post should call update_rank on post" do
      expect(post).to receive(:update_rank).at_least(:once)
      vote.save!
    end

  end

end
