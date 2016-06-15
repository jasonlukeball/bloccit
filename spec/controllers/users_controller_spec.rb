require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user_attributes) do
    {
      name: "Example User",
      email: "user@example.com",
      password: "password", password_confirmation: "password"
    }
  end


  describe "GET new" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status :success
    end

    it "instantiates a new user" do
      get :new
      expect(assigns(:user)).to_not be_nil
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end

  end


  describe "POST create" do

    it "returns a http redirect" do
      post :create, user: user_attributes
      expect(response).to have_http_status :redirect
    end

    it "creates a new user" do
      expect{post :create, user: user_attributes}.to change(User, :count).by(1)
    end

    it "sets the name correctly" do
      post :create, user: user_attributes
      expect(assigns(:user).name).to eq user_attributes[:name]
    end

    it "sets the email correctly" do
      post :create, user: user_attributes
      expect(assigns(:user).email).to eq user_attributes[:email]
    end

    it "sets the password correctly" do
      post :create, user: user_attributes
      expect(assigns(:user).password).to eq user_attributes[:password]
    end

    it "sets the password_confirmation correctly" do
      post :create, user: user_attributes
      expect(assigns(:user).password_confirmation).to eq user_attributes[:password_confirmation]
    end

    it "logs the user in after sign up" do
      post :create, user: user_attributes
      expect(session[:user_id]).to eq assigns(:user).id
    end


  end


  describe "not signed in" do

    let(:factory_user)  { create(:user) }

    before do
      post :create, user: attributes_for(:user)
    end

    it "returns http success" do
      get :show, { id: factory_user.id }
      expect(response).to have_http_status :success
    end

    it "it renders the user#show view" do
      get :show, { id: factory_user.id }
      expect(response).to render_template :show
    end

    it "it assigns factory_user to @ user" do
      get :show, { id: factory_user.id }
      expect(assigns(:user)).to eq(factory_user)
    end

  end


end
