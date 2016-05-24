class Post < ActiveRecord::Base
  belongs_to :topic
  has_many :comments, dependent: :destroy

  after_create :censor

  def censor
    update_attribute(:title, "SPAM") if self.id % 5 == 0
  end

end
