require 'rails_helper'
include SessionsHelper

RSpec.describe VotesController, type: :controller do

  let(:user)          { create(:user) }
  let(:user2)         { create(:user) }
  let(:a_topic)       { create(:topic) }
  let(:a_post)        { create(:post, topic: a_topic)}


  context "guest" do

    describe "POST up_vote" do
      it "redirects the person to sign in" do
        post :up_vote, post_id: a_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST down_vote" do
      it "redirects the person to sign in" do
        post :down_vote, post_id: a_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end

  end

  context "signed in user" do

    before do
      create_session(user2)
      request.env["HTTP_REFERER"] = topic_post_path(a_topic, a_post)
    end

    describe "POST up_vote" do
      it "the user's first vote increases the number of votes by one" do
        votes_count = a_post.votes.count
        post :up_vote, post_id: a_post.id
        expect(a_post.votes.count).to eq(votes_count + 1)
      end

      it "the user's second vote does not increase the votes count" do
        post :up_vote, post_id: a_post.id
        votes_count = a_post.votes.count
        post :up_vote, post_id: a_post.id
        expect(a_post.votes.count).to eq(votes_count)
      end

      it "increases the sum of votes count by one" do
        vote_points = a_post.points
        post :up_vote, post_id: a_post.id
        expect(a_post.points).to eq(vote_points + 1)
      end

      it ":back voting from posts#show view redirects to the post show page" do
        request.env["HTTP_REFERER"] = topic_post_path(a_topic, a_post)
        post :up_vote, post_id: a_post.id
        expect(response).to redirect_to([a_topic, a_post])
      end

      it ":back voting from topic#show view redirects to topic show view" do
        request.env["HTTP_REFERER"] = topic_path(a_topic)
        post :up_vote, post_id: a_post.id
        expect(response).to redirect_to(a_topic)
      end

    end


    describe "POST down_vote" do
      it "the user's first vote increases the number of votes by one" do
        votes_count = a_post.votes.count
        post :down_vote, post_id: a_post.id
        expect(a_post.votes.count).to eq(votes_count + 1)
      end

      it "the user's second vote does not decrease the votes count" do
        post :down_vote, post_id: a_post.id
        votes_count = a_post.votes.count
        post :down_vote, post_id: a_post.id
        expect(a_post.votes.count).to eq(votes_count)
      end

      it "decreases the sum of votes count by one" do
        vote_points = a_post.points
        post :down_vote, post_id: a_post.id
        expect(a_post.points).to eq(vote_points - 1)
      end

      it ":back voting from posts#show view redirects to the post show page" do
        request.env["HTTP_REFERER"] = topic_post_path(a_topic, a_post)
        post :down_vote, post_id: a_post.id
        expect(response).to redirect_to([a_topic, a_post])
      end

      it ":back voting from topic#show view redirects to topic show view" do
        request.env["HTTP_REFERER"] = topic_path(a_topic)
        post :down_vote, post_id: a_post.id
        expect(response).to redirect_to(a_topic)
      end

    end










  end


end
