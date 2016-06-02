class PostsController < ApplicationController

  before_action :require_sign_in, except: [:show]
  before_action :authorise_user, except: [:show, :new, :create]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      # if saving the instance of post to the database was successful, we display a success message using flash[:notice]
      flash[:notice] = 'Post was saved.'
      # and redirect the user to the route generated by @post.
      # Redirecting to @post will direct the user to the posts show view.
      redirect_to [@topic, @post]
    else
      # if saving the instance of post was not successful, we display an error message and render the new view again.
      flash[:alert] = 'There was an error saving the post. Please try again'
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post successfully updated!"
      redirect_to [@post.topic, @post]
    else
      flash[:alert] = "Error updating post, please try again"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash[:alert] = "Post could not be deleted, please try again"
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorise_user
    post = Post.find(params[:id])
    unless current_user == post.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to [post.topic, post]
    end
  end

end
