require 'rails_helper'

RSpec.describe LabelsController, type: :controller do

  let(:a_label) {Label.create!(name: "Example Label")}

  describe "GET show" do
    it "returns http success" do
      get :show, { id: a_label.id }
      expect(response).to have_http_status :success
    end

    it "renders the show view" do
      get :show, { id: a_label.id }
      expect(response).to render_template :show
    end

    it "assigns a_label to @label" do
      get :show, { id: a_label.id }
      expect(assigns(:label)).to eq(a_label)
    end

  end

end
