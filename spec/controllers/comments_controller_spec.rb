require 'rails_helper'
include SessionsHelper

RSpec.describe CommentsController, type: :controller do

  let(:user1)             { create(:user) }
  let(:user2)             { create(:user) }
  let(:admin_user)        { create(:user,role: "admin") }
  let(:a_topic)           { create(:topic) }
  let(:user1_post)        { create(:post, topic: a_topic, user: user1) }
  let(:user1_comment)     {user1_post.comments.create!(body: Faker::Hipster.sentence, user: user1)}
  let(:user2_comment)     {user1_post.comments.create!(body: Faker::Hipster.sentence, user: user2)}


  context "guest user" do

    describe "POST create" do
      it "redirects the guest to sign in" do
        post :create, format: :js, post_id: user1_post.id, comment: {body: Faker::Hipster.sentence}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      it "redirects the guest to sign in" do
        delete :destroy, format: :js, post_id: user1_post.id, id: user1_comment.id
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
        expect{post :create, format: :js, post_id: user1_post.id, comment: {body: Faker::Hipster.sentence, user: user1}}.to change(Comment,:count).by(1)
      end

      it "redirects to the post show view" do
        post :create, format: :js, post_id: user1_post.id, comment: {body: Faker::Hipster.sentence, user: user1}
        expect(response).to have_http_status :success
      end
    end

    describe "DELETE destroy" do
      it "deletes the comment" do
        delete :destroy, format: :js, post_id: user1_post.id, id: user1_comment.id
        count = Comment.where(id: user1_comment.id).count
        expect(count).to eq 0
      end

      it "returns http success" do
        delete :destroy, format: :js, post_id: user1_post.id, id: user1_comment.id
        expect(response).to have_http_status(:success)
      end
    end

  end

  context "user attempting to delete another user's comments" do

    before do
      create_session(user2)
    end

    describe "DELETE destroy" do
      it "does not delete the comment" do
        delete :destroy, format: :js, post_id: user1_post.id, id: user1_comment.id
        count = Comment.where(commentable_id: user1_comment.id).count
        expect(count).to eq 1
      end

      it "redirects to the post show view" do
        delete :destroy, format: :js, post_id: user1_post.id, id: user1_comment.id
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
        delete :destroy, format: :js, post_id: user1_post.id, id: user1_comment.id
        count = Comment.where(id: user1_comment.id).count
        expect(count).to eq 0
      end

      it "returns http success" do
        delete :destroy, format: :js, post_id: user1_post.id, id: user1_comment.id
        expect(response).to have_http_status(:success)
      end
    end

  end


end
