require 'rails_helper'
include SessionsHelper

RSpec.describe FavouritesController, type: :controller do

  let(:a_user)    { create(:user) }
  let(:a_topic)   { create(:topic) }
  let(:a_post)    { create(:post, topic: a_topic, user: a_user) }

  context "guest user" do

    describe "POST create" do
      it "redirects the guest to sign in" do
        post :create, params: { post_id: a_post.id }
        expect(response).to redirect_to new_session_path
      end

      describe "DELETE destroy" do
        it "redirects the guest to sign in" do
          favourite = a_user.favourites.create!(post: a_post)
          delete :destroy, params: { post_id: a_post.id, id: favourite.id}
          expect(response).to redirect_to new_session_path
        end
      end
    end
  end

  context "signed in user" do

    before do
      create_session(a_user)
    end

    describe "POST create" do
      it "redirects to the post show view" do
        post :create, params: { post_id: a_post.id }
        expect(response).to redirect_to([a_topic, a_post])
      end

      it "creates a favourite for the post" do
        expect(a_user.favourites.find_by_post_id(a_post.id).nil?).to_not be_nil
        post :create, params: { post_id: a_post.id }
        expect(a_user.favourites.find_by_post_id(a_post.id)).to_not be_nil
      end
    end

    describe "DELETE destroy" do
      it "redirects to the post show view" do
        favourite = a_user.favourites.create!(post: a_post)
        delete :destroy, params: { post_id: a_post.id, id: favourite.id}
        post :create, params: { post_id: a_post.id }
        expect(response).to redirect_to([a_topic, a_post])
      end

      it "deletes the favourite for the post" do
        favourite = a_user.favourites.find_by_post_id(a_post.id) # favourite already created when post is by the post create_favourite callback
        expect(a_user.favourites.find_by_post_id(a_post.id)).to_not be_nil
        delete :destroy, params: { post_id: a_post.id, id: favourite.id}
        expect(a_user.favourites.find_by_post_id(a_post.id)).to be_nil
      end
    end
  end

end
