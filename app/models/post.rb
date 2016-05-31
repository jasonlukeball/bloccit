class Post < ActiveRecord::Base

  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum:  5}, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  after_create :censor

  def censor
    update_attribute(:title, "SPAM") if self.id % 5 == 0
  end

end
