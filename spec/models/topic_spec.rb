require 'rails_helper'

RSpec.describe Topic, type: :model do

  let(:name)          { Faker::Hipster.sentence }
  let(:description)   { Faker::Hipster.paragraph }
  let(:public)        { true }
  let(:topic)         { Topic.create!(name: name, description: description)}

  describe "attributes" do

    it "should have name, description and public attributes" do
      expect(topic).to have_attributes(name: name, description: description, public: public)
    end

    it "should be public by default" do
      a_topic = Topic.create!(name: name, description: description)
      expect(a_topic.public).to be(true)
    end

    it { is_expected.to have_many(:posts) }

  end


end
