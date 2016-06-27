class Api::V1::PostsController < Api::V1::BaseController

  before_action :authenticate_user, except: [:index, :show]
  before_action :authorise_user_update, only: [:update]
  before_action :authorise_user_delete, only: [:destroy]

  def index
    render json: Post.all, status: 200
  end

  def show
    render :json => Post.find(params[:id]), :include => [:comments], status: 200
  end

  def create
    topic = Topic.find(params[:topic_id])
    post = topic.posts.build(post_params)
    post.user = @current_user

    if post.valid?
      post.save!
      render json: post, status: 201
    else
      render json: { errors: post.errors.messages, status: 400 }, status: 400
    end
  end

  def update
    post = Post.find(params[:id])
    post.assign_attributes(post_params)
    if post.valid?
      post.save!
      render json: post, status: 200
    else
      render json: { error: post.errors.messages, status: 400 }, status: 400
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      render json: { message: "Post deleted", status: 200 }, status: 200
    else
      render json: { error: "Post could not be deleted", status: 400 }, status: 400
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorise_user_update
    post = Post.find(params[:id])
    unless @current_user == post.user || @current_user.admin? || @current_user.moderator?
      render json: { error: "You don't have permission to update this post", status: 403 }, status: 403

    end
  end

  def authorise_user_delete
    post = Post.find(params[:id])
    unless @current_user == post.user || @current_user.admin?
      render json: { error: "You don't have permission to delete this post", status: 403 }, status: 403
    end

  end

end