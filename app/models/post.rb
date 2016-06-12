class Post < ActiveRecord::Base

  belongs_to :topic
  belongs_to :user

  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :title, length: { minimum:  5}, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  after_create :censor


  # SCOPES
  default_scope { order('rank DESC') }

  def self.ordered_by_title
    order('title ASC')
  end


  def self.ordered_by_reverse_created_at
    order('created_at ASC')
  end


  def censor
    update_attribute(:title, "SPAM") if self.id % 5 == 0
  end

  # voting

  def up_votes
    self.votes.where(value: 1).count
  end


  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value)
  end

  def update_rank
    age_in_days = (self.created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = self.points + age_in_days
    update_attribute(:rank, new_rank)
  end

end
