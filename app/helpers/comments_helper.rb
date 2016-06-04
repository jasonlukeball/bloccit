module CommentsHelper

  def user_can_delete_comment?(comment)
    current_user && (current_user == comment.user || current_user.admin?)
  end

end
