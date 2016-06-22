module CommentsHelper


  def user_can_delete_comment?(comment)
    current_user && (current_user == comment.user || current_user.admin?)
  end

  def delete_comment_link(comment)
    if comment.commentable.class.name == "Topic"
      link_to "Delete", topic_comment_path(comment.commentable.id, comment), method: :delete, remote: true
    elsif comment.commentable.class.name == "Post"
      link_to "Delete", post_comment_path(comment.commentable.id, comment), method: :delete, remote: true
    end
  end

end
