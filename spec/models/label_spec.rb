require 'rails_helper'

RSpec.describe Label, type: :model do

  let(:a_user)      { create(:user) }
  let(:a_topic)     { create(:topic) }
  let(:a_post)      { create(:post) }
  let(:label1)      { Label.create!(name: "Example Label 1") }
  let(:label2)      { Label.create!(name: "Example Label 2") }

  it { is_expected.to have_many :labelings }
  it { is_expected.to have_many :topics }
  it { is_expected.to have_many :posts }

  describe "Labelings" do
    it "allows the same label to be associated with a different topic or post" do
      a_topic.labels << label1
      a_post.labels << label1
      topic_label   = a_topic.labels.first
      post_label    = a_post.labels.first
      expect(topic_label).to eq(post_label)
    end

    describe ".update_labels" do
      it "takes a comma delimited string and returns an array of labels" do
        labels      = "#{label1.name}, #{label2.name}"
        labels_as_a = [label1, label2]
        expect(Label.update_labels(labels)).to eq(labels_as_a)
      end
    end

  end

end