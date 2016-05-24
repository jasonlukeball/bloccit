require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do

  let(:topic)                 {Topic.create!(name: Faker::Hipster.sentence, description: Faker::Hipster.paragraph)}
  let(:sponsored_post_title)  {Faker::Hipster.sentence}
  let(:sponsored_post_body)   {Faker::Hipster.paragraph}
  let(:sponsored_post_price)  {rand(0..1000)}

  let(:sponsored_post)        {topic.sponsored_posts.create!(title: sponsored_post_title, body: sponsored_post_body, price: sponsored_post_price)}

  it { is_expected.to belong_to :topic }

  describe "attributes" do

    it "should have the correct attributes" do
      expect(sponsored_post).to have_attributes(title: sponsored_post_title, body: sponsored_post_body, price: sponsored_post_price)
    end

  end



end
