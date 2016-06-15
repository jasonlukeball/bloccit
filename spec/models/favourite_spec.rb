require 'rails_helper'

RSpec.describe Favourite, type: :model do

  let(:user)      { create(:user) }
  let(:topic)     { create(:topic) }
  let(:post)      { create(:post) }
  let(:favourite) { Favourite.create!(post: post, user: user) }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

end
