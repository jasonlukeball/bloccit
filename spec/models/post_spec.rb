require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:topic_name)          { Faker::Hipster.sentence }
  let(:topic_description)   { Faker::Hipster.paragraph }
  let(:post_title)          { Faker::Hipster.sentence }
  let(:post_body)           { Faker::Hipster.paragraph }

  let(:topic)               { Topic.create!(name: topic_name, description: topic_description) }
  let(:post)                { topic.posts.create!(title: post_title, body: post_body) }

  it { is_expected.to belong_to(:topic) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :topic }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }



  describe "attributes" do
    it "has the title and body attributes" do
      expect(post).to have_attributes(title: post_title, body: post_body)
    end
  end

end
