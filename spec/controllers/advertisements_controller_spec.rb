require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do

  let(:ad) { Advertisement.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, price: 100) }

  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the index view" do
      get :index
      expect(response).to render_template :index
    end

    it "instantiates @advertisements" do
      get :index
      expect(assigns(:advertisements)).to_not be_nil
    end



  end

  describe "GET #show" do

    it "returns http success" do
      get :show, params: {id: ad.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the show view" do
      get :show, params: {id: ad.id}
      expect(response).to render_template :show
    end

    it "assigns advertisement to @advertisement" do
      get :show, params: {id: ad.id}
      expect(assigns(:advertisement)).to eq(ad)
    end

  end

  describe "GET #new" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @advertisement" do
      get :new
      expect(assigns[:advertisement]).to_not be_nil
    end

  end

  describe "POST #create" do

    it "increases the number of advertisements by 1" do
      expect{post :create, params: {advertisement: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, price: 100}}}.to change(Advertisement,:count).by(1)
    end

    it "assigns the new advertisement to @advertisement" do
      post :create, params: {advertisement: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, price: 100}}
      expect(assigns(:advertisement)).to eq(Advertisement.last)
    end

    it "redirects to the new advertisement" do
      post :create, params: {advertisement: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, price: 100}}
      expect(response).to redirect_to(Advertisement.last)
    end

    it "displays a flash success message" do
      post :create, params: {advertisement: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, price: 100}}
      expect(response).to redirect_to(Advertisement.last)
      expect(flash[:notice]).to eq("Advertisement was saved.")

    end

  end

end
