class CommentsController < ApplicationController

  before_action :require_sign_in
  before_action :authorise_delete, only: [:destroy]
  before_action :determine_commentable_class


  def create
    comment = @commentable.comments.new(comment_params)
    comment.user = current_user
    if comment.save
      flash[:notice] = "Comment Saved!"
      determine_redirect(comment)
    else
      flash[:alert] = "Error saving comment, please try again!"
      determine_redirect(comment)
    end
  end


  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      flash[:notice] = "Comment Deleted!"
      determine_redirect(comment)
    else
      flash[:alert] = "Comment could not be deleted, please try again!"
      determine_redirect(comment)
    end
  end



  private

  def comment_params
    params.require(:comment).permit(:body, :commentable)
  end

  def authorise_delete
    comment = Comment.find(params[:id])
    unless comment.user == current_user || current_user.admin?
      flash[:alert] = "You don't have permission to delete that comment!"
      redirect_to [comment.commentable.topic, comment.commentable]
    end
  end

  def determine_commentable_class
    klass = [Topic, Post].detect{|c| params["#{c.name.underscore}_id"]}
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def determine_redirect(comment)
    if @commentable.class.name == "Topic"
      redirect_to topic_path(comment.commentable)
    elsif @commentable.class.name == "Post"
      redirect_to topic_post_path(comment.commentable.topic, comment.commentable)
    end
  end


end
