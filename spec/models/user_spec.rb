require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user)  { create(:user) }
  let(:user2) { create(:user) }

  it { is_expected.to have_many(:topics) }
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favourites) }

  # Name
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  # Email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@example.com").for(:email) }

  # Password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }


  describe "attributes" do

    it "should have name and email attributes" do
      expect(user).to have_attributes(name: user.name, email: user.email)
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end

    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end

  end

  describe "roles" do


    context "member user" do

      it "is member by default" do
        expect(user.role).to eq("member")

      end

      it "it returns true for member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for admin?" do
        expect(user.admin?).to be_falsey
      end

    end


    context "admin user" do

      before do
        user.admin!
      end

      it "it returns true for admin?" do
        expect(user.admin?).to be_truthy
      end

      it "returns false for member?" do
        expect(user.member?).to be_falsey
      end

    end


  end

  describe "invalid user" do

    let(:user_with_invalid_name) { build(:user, name: "") }
    let(:user_with_invalid_email) { build(:user, email: "") }

    it "should be an invalid user due to a blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email address" do
      expect(user_with_invalid_email).to_not be_valid
    end

  end

  describe "user name capitalization" do

    let(:user_with_lower_case_name) {User.new(name: "example user", email: "user2@example.com", password: "password")}

    it "should capitalize user's name" do
      Rails.logger.debug ">>>>> user: #{user_with_lower_case_name.inspect}"
      user_with_lower_case_name.save
      expect(user_with_lower_case_name.name).to eq "Example User"
    end

  end

  describe "#favourite_for(post)" do

    before do
      topic = Topic.create!(name: Faker::Hipster.sentence, description: Faker::Hipster.paragraph)
      @post = topic.posts.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: user)
    end

    it "returns nil if the user has not favourited the post" do
      expect(user2.favourite_for(@post)).to be_nil
    end

    it "returns the appropriate favourite if it exists" do
      favourite = user.favourites.find_by_post_id(@post.id)
      expect(user.favourite_for(@post)).to eq(favourite)
    end

  end

  describe ".avatar_url" do
    let(:known_user) { create(:user, email: "jasonlukeball.me.com") }
    it "returns the proper gravatar url for a know email entity" do
      expected_gravater = "http://gravatar.com/avatar/3c54b88a4035a1da59b9914ef85312fc.png?s=28"
      expect(known_user.avatar_url(28)).to eq(expected_gravater)
    end


  end

  describe "#generate_auto_token" do
    it "creates a token" do
      expect(user.auth_token).to_not be_nil
    end
  end

end
