require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  let(:my_user) { create(:user) }


  context "unauthenticated users" do

    it "GET index returns http unauthenticated" do
      get :index
      expect(response).to have_http_status(401)
    end

    it "GET show returns http unauthenticated" do
      get :show, id: my_user.id
      expect(response).to have_http_status(401)
    end

    it "POST create returns http unauthenticated" do
      new_user = build(:user)
      post :create, user: { name: new_user.name, email: new_user.email, password: new_user.password }
      expect(response).to have_http_status(401)
    end

    it "PUT update returns http unauthenticated" do
      new_user = build(:user)
      put :update, id: my_user.id, user: { name: new_user.name, email: new_user.email, password: new_user.password }
      expect(response).to have_http_status(401)
    end


  end


  context "authenticated, but unauthorised users (valid user but not admin)" do

    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it "GET index returns http forbidden" do
      get :index
      expect(response).to have_http_status(403)
    end

    it "GET show returns http forbidden" do
      get :show, id: my_user.id
      expect(response).to have_http_status(403)
    end

    it "POST create returns http unauthenticated" do
      new_user = build(:user)
      post :create, user: { name: new_user.name, email: new_user.email, password: new_user.password }
      expect(response).to have_http_status(403)
    end

    it "PUT update returns http unauthenticated" do
      new_user = build(:user)
      put :update, id: my_user.id, user: { name: new_user.name, email: new_user.email, password: new_user.password }
      expect(response).to have_http_status(403)
    end


  end


  context "authenticated and authorised users" do

    before do
      my_user.admin!
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    describe "GET index" do
      before { get :index }

      it "returns http success" do
        expect(response).to have_http_status :success
      end

      it "returns json content type" do
        expect(response.content_type).to eq("application/json")
      end

      it "returns my_user serialised" do
        expect(response.body).to eq([my_user].to_json)
      end
    end

    describe "GET show" do
      before { get :show, id: my_user.id }

      it "returns http success" do
        expect(response).to have_http_status :success
      end

      it "returns json content type" do
        expect(response.content_type).to eq("application/json")
      end

      it "returns my_user serialised" do
        expect(response.body).to eq(my_user.to_json)
      end
    end

    describe "PUT update" do


      context "with valid attributes" do

        before do
          @new_user = build(:user, role: 'admin')
          put :update, id: my_user.id, user: { name: @new_user.name, email: @new_user.email, password: @new_user.password, role: @new_user.role }
        end

        it "returns http success" do
          expect(response).to have_http_status :success
        end

        it "responds with json content type" do
          expect(response.content_type).to eq 'application/json'
        end

        it "updates the user with the correct attributes" do
          hashed_json = JSON.parse(response.body)
          expect(hashed_json['name']).to eq @new_user.name
          expect(hashed_json['email']).to eq @new_user.email
          expect(hashed_json['role']).to eq @new_user.role
        end
      end


      context "with invalid attributes" do

        before do
          put :update, id: my_user.id, user: { name: "", email: "bademail@", password: "short" }
        end

        it "returns http error 400" do
          expect(response).to have_http_status(400)
        end

        it "returns the correct error message as json" do
          expect(response.body).to eq( {error: "User update failed", status: 400}.to_json )
        end
      end
    end


    describe "POST create" do


      context "with valid attributes" do

        before do
          @new_user = build(:user, role: "admin")
          post :create, user: { name: @new_user.name, email: @new_user.email, password: @new_user.password, role: @new_user.role }
        end

        it "returns http success" do
          expect(response).to have_http_status :success
        end

        it "returns json content type" do
          expect(response.content_type).to eq 'application/json'
        end

        it "created a user with the correct attributes" do
          response_json = JSON.parse(response.body)
          expect(response_json['name']).to eq @new_user.name
          expect(response_json['email']).to eq @new_user.email
          expect(response_json['role']).to eq @new_user.role
        end
      end

      context "with invalid attributes" do

        before do
          post :create, user: { name: "", email: "notanem@", password: "short" }
        end

        it "returns http error" do
          expect(response).to have_http_status(400)
        end

        it "returns the correct json error message" do
          expect(response.body).to eq( { error: "User is invalid", status: 400 }.to_json )
        end
      end
    end
  end
end
