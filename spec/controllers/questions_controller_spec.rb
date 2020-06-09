require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:question) { Question.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, resolved: false)}

  describe "GET new" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status :success
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @question" do
      get :new
      expect(assigns(:question)).to_not be_nil
    end

  end

  describe "POST create" do

    it "increases the number of questions by 1" do
      expect{post :create, params: {question:{title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, resolved: rand(0..1)}}}.to change(Question,:count).by 1
    end

    it "assigns the new question to @question" do
      post :create, params: {question:{title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, resolved: rand(0..1)}}
      expect(assigns(:question)).to eq(Question.last)
    end

    it "redirects to the new question" do
      post :create, params: {question:{title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, resolved: rand(0..1)}}
      expect(response).to redirect_to Question.last
    end

  end

  describe "GET show" do

    it "returns http success" do
      get :show, params: {id: question.id}
      expect(response).to have_http_status :success
    end

    it "renders the show view" do
      get :show, params: {id: question.id}
      expect(response).to render_template :show
    end

    it "assigns the question to @question" do
      get :show, params: {id: question.id}
      expect(assigns(:question)).to eq(question)
    end

  end

  describe "GET edit" do

    it "returns http success" do
      get :edit, params: {id: question.id}
      expect(response).to have_http_status :success

    end

    it "renders the edit view" do
      get :edit, params: {id: question.id}
      expect(response).to render_template :edit
    end

    it "assigns question to @question" do
      get :edit, params: {id: question.id}
      question_instance = assigns(:question)
      expect(question_instance.title).to eq question.title
      expect(question_instance.body).to eq question.body
      expect(question_instance.resolved).to eq question.resolved
    end


  end

  describe "PUT update" do

    it "updates the question with expected attributes" do
      new_title     = Faker::Hipster.sentence
      new_body      = Faker::Hipster.paragraph
      new_resolved  = true
      put :update, params: {id: question.id, question: {title: new_title, body: new_body, resolved: new_resolved}}
      updated_question = assigns(:question)
      expect(updated_question.title).to eq(new_title)
      expect(updated_question.body).to eq(new_body)
      expect(updated_question.resolved).to eq(new_resolved)
    end

    it "redirects to updated question" do
      new_title     = Faker::Hipster.sentence
      new_body      = Faker::Hipster.paragraph
      new_resolved  = true
      put :update, params: {id: question.id, question: {title: new_title, body: new_body, resolved: new_resolved}}
      expect(response).to redirect_to question
    end

  end

  describe "DELETE destroy" do

    it "deleted the question" do
      delete :destroy, params: {id: question.id}
      count = Question.where({id: question.id}).count
      expect(count).to eq 0
    end

    it "redirects to the index view" do
      delete :destroy, params: {id: question.id}
      expect(response).to redirect_to questions_path
    end

  end








end
