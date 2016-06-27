require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  #expect{ post :create, topic_id: my_topic.id, post: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph} }.to change(Post,:count).by(1)

  let(:my_user)     { create(:user) }
  let(:my_topic)    { create(:topic) }
  let(:my_post)     { create(:post, topic: my_topic, title: "A New Post", body: "A New Post Body with mor ethan 20 characters", user: my_user) }

  context "unauthenticated user" do
    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status :success
    end

    it "GET show returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status :success
    end

    it "PUT update" do
      put :update, id: my_post.id, post: { title: "Updated Post Title", body: "Updated Post Body" }
      expect(response).to have_http_status(401)
    end

    it "POST create" do
      post :create, post: { title: "New Post Title", body: "New Post Body" }
      expect(response).to have_http_status(401)
    end

    it "DELETE destroy" do
      delete :destroy, id: my_post.id
      expect(response).to have_http_status(401)
    end

  end

  context "unauthorised user" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status :success
    end

    it "GET show returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status :success
    end
  end

  context "authenticated user" do

    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
      @new_post = build(:post, title: "NEW TITLE")
    end

    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status :success
    end

    it "GET show returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status :success
    end


    describe "PUT update" do
      before { put :update, topic_id: my_topic.id, id: my_post.id, post: { name: @new_post.title, body: @new_post.body } }

      it "returns http success" do
        expect(response).to have_http_status :success
      end

      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end

      it "updates the topic with the correct attributes" do
        updated_post = Post.find(my_post.id)
        expect(response.body).to eq(updated_post.to_json)
      end

    end

    describe "POST create" do

      before { post :create, topic_id: my_topic.id, post: { title: @new_post.title, body: @new_post.body } }

      it "returns http success" do
        expect(response).to have_http_status :success
      end

      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end

      it "created a new post with the correct attributes" do
        response_json_as_hash = JSON.parse(response.body)
        expect(response_json_as_hash['title']).to eq(@new_post.title)
        expect(response_json_as_hash['body']).to eq(@new_post.body)
      end
    end

    describe "DELETE destroy" do

      before { delete :destroy, topic_id: my_topic.id, id: my_post.id }

      it "returns http success" do
        expect(response).to have_http_status :success
      end

      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end

      it "returns the correct success message" do
        expect(response.body).to eq({message: "Post deleted", status: 200}.to_json)
      end

      it "deletes the topic" do
        expect{Post.find(my_post.id)}.to raise_exception(ActiveRecord::RecordNotFound)
      end

    end
  end

end