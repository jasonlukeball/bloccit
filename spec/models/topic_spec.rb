require 'rails_helper'

RSpec.describe Topic, type: :model do

  let(:name)          { Faker::Hipster.sentence }
  let(:description)   { Faker::Hipster.paragraph }
  let(:public)        { true }
  let(:topic)         { Topic.create!(name: name, description: description)}

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }


  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_length_of(:name).is_at_least(5) }
  it { is_expected.to validate_length_of(:description).is_at_least(15) }

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
