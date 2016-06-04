require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {User.create!(name: "Example User", email: "user@example.com", password: "password")}

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }

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
      expect(user).to have_attributes(name: "Example User", email: "user@example.com")
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

    let(:user_with_invalid_name)  { User.new(name: "", email: "user@example.com") }
    let(:user_with_invalid_email) { User.new(name: "Example User", email: "") }

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

end
