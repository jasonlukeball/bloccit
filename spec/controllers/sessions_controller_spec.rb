require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user) {User.create!(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password")}


  describe "GET new" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status :success
    end

  end


  describe "POST sessions" do

    it "returns http success" do
      post :create, session: {email: user.email}
      expect(response).to have_http_status :success

    end

    it "initializes a session" do
      post :create, session: {email: user.email, password: user.password}
      expect(session[:user_id]).to eq user.id
    end

    it "does not add user id to session due to missing password" do
      post :create, session: {email: user.email}
      expect(session[:user_id]).to be_nil
    end

    it "flashes an error with a bad email address" do
      post :create, session: {email: "not an email address"}
      expect(flash.now[:alert]).to_not be_nil
    end

    it "renders new with a bad email address" do
      post :create, session: {email: "not an email address"}
      expect(response).to render_template :new
    end

    it "redirects to the root view" do
      post :create, session: {email: user.email, password: user.password}
      expect(response).to redirect_to root_path
    end

  end


  describe "DELETE sessions/id" do

    it "redirects to the root view" do
      delete :destroy, id: user.id
      expect(response).to redirect_to root_path
    end

    it "deletes the user's session" do
      delete :destroy, id: user.id
      expect(assigns[:session]).to be_nil
    end

    it "flashes a notice" do
      delete :destroy, id: user.id
      expect(flash[:notice]).to_not be_nil
    end

  end

end
