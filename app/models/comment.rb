class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, length: { minimum: 5 }, presence: true

  after_create :send_favourite_emails


  private

  def send_favourite_emails
    if self.commentable.class.name == "Post"
      self.commentable.favourites.each {|f| FavouriteMailer.new_comment(f.user, self.commentable, self).deliver_now }
    end
  end

end
