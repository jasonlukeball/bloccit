require 'rails_helper'

RSpec.describe Topic, type: :model do

  let(:name)          { Faker::Hipster.sentence }
  let(:description)   { Faker::Hipster.paragraph }
  let(:public)        { true }
  let(:topic)         { create(:topic) }

  let(:known_user) { create(:user, email: "jasonlukeball.me.com") }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_length_of(:name).is_at_least(5) }
  it { is_expected.to validate_length_of(:description).is_at_least(15) }

  describe "attributes" do

    it "should have name, description and public attributes" do
      expect(topic).to have_attributes(name: topic.name, description: topic.description, public: public)
    end

    it "should be public by default" do
      a_topic = Topic.create!(name: name, description: description)
      expect(a_topic.public).to be(true)
    end

    it { is_expected.to have_many(:posts) }

  end

  describe "scopes" do

    before do
      @public_topic = Topic.create!(name: Faker::Hipster.sentence, description: Faker::Hipster.paragraph)
      @private_topic = Topic.create!(name: Faker::Hipster.sentence, description: Faker::Hipster.paragraph, public: false)
    end

    describe "visible_to(user)" do
      it "returns all topics if the user is present" do
        user = User.new
        expect(Topic.visible_to(user)).to eq(Topic.all)
      end

      it "only returns public topics if the user is not present" do
        expect(Topic.visible_to(nil)).to eq(Topic.where(public: true))
      end
    end



  end

end
