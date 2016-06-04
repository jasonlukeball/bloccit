class CommentsController < ApplicationController

  before_action :require_sign_in
  before_action :authorise_delete, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user
    if comment.save
      flash[:notice] = "Comment Saved!"
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Error saving comment, please try again!"
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    if comment.destroy
      flash[:notice] = "Comment Deleted!"
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Comment could not be deleted, please try again!"
      redirect_to [@post.topic, @post]
    end
  end



  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorise_delete
    comment = Comment.find(params[:id])
    unless comment.user == current_user || current_user.admin?
      flash[:alert] = "You don't have permission to delete that comment!"
      redirect_to [comment.post.topic, comment.post]
    end
  end


end
