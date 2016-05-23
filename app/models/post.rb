class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  after_create :censor

  def censor
    update_attribute(:title, "SPAM") if self.id % 5 == 0
  end

end
