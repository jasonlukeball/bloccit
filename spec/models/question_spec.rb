require 'rails_helper'

RSpec.describe Question, type: :model do

  let (:question) { Question.create!(title: "New Question Title", body: "New Question Body", resolved: true)}

  describe "attributes" do
    it "has a title, body and resolved attribute" do
      expect(question).to have_attributes(title: "New Question Title", body: "New Question Body", resolved: true)
    end
  end

end
