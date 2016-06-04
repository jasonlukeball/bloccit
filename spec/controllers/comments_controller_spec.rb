require 'rails_helper'
include SessionsHelper

RSpec.describe CommentsController, type: :controller do

  let(:user1)             {User.create!(name: "User1", email: "user1@example.com", password: "password")}
  let(:user2)             {User.create!(name: "User2", email: "user2@example.com", password: "password")}
  let(:admin_user)        {User.create!(name: "Admin User", email: "admin@example.com", password: "password", role: "admin")}

  let(:a_topic)           {Topic.create!(name: Faker::Hipster.sentence, description: Faker::Hipster.paragraph)}
  let(:user1_post)        {a_topic.posts.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, user: user1)}
  let(:user1_comment)     {user1_post.comments.create!(body: Faker::Hipster.sentence, user: user1)}
  let(:user2_comment)     {user1_post.comments.create!(body: Faker::Hipster.sentence, user: user2)}



  context "guest user" do

    describe "POST create" do
      it "redirects the guest to sign in" do
        post :create, post_id: user1_post.id, comment: {body: Faker::Hipster.sentence}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects the guest to sign in" do
        delete :destroy, post_id: user1_post.id, id: user1_comment.id
        expect(response).to redirect_to(new_session_path)
      end
    end

  end


  context "user doing CRUD" do

    before do
      create_session(user1)
    end

    describe "POST create" do
      it "increases the number of comments by 1" do
        expect{post :create, post_id: user1_post.id, comment: {body: Faker::Hipster.sentence, user: user1}}.to change(Comment,:count).by(1)
      end

      it "redirects to the post show view" do
        post :create, post_id: user1_post.id, comment: {body: Faker::Hipster.sentence, user: user1}
        expect(response).to redirect_to([a_topic, user1_post])
      end
    end

    describe "DELETE destroy" do
      it "deletes the comment" do
        delete :destroy, post_id: user1_post.id, id: user1_comment.id
        count = Comment.where(id: user1_comment.id).count
        expect(count).to eq 0
      end

      it "redirects to the post show view" do
        delete :destroy, post_id: user1_post.id, id: user1_comment.id
        expect(response).to redirect_to([a_topic, user1_post])

      end
    end

  end


  context "user attempting to delete another user's comments" do

    before do
      create_session(user2)
    end

    describe "DELETE destroy" do
      it "does not delete the comment" do
        delete :destroy, post_id: user1_post.id, id: user1_comment.id
        count = Comment.where(id: user1_comment.id).count
        expect(count).to eq 1
      end

      it "redirects to the post show view" do
        delete :destroy, post_id: user1_post.id, id: user1_comment.id
        expect(response).to redirect_to([a_topic, user1_post])
      end
    end

  end



  context "admin attempting to delete another user's comments" do

    before do
      create_session(admin_user)
    end

    describe "DELETE destroy" do
      it "deletes the comment" do
        delete :destroy, post_id: user1_post.id, id: user1_comment.id
        count = Comment.where(id: user1_comment.id).count
        expect(count).to eq 0
      end

      it "redirects to the post show view" do
        delete :destroy, post_id: user1_post.id, id: user1_comment.id
        expect(response).to redirect_to([a_topic, user1_post])
      end
    end

  end







end
