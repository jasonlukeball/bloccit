class Api::V1::PostsController < Api::V1::BaseController

  before_action :authenticate_user, except: [:index, :show]
  before_action :authorise_user, except: [:index, :show]

  def index
    render json: Post.all, status: 200
  end

  def show
    render :json => Post.find(params[:id]), :include => [:comments], status: 200
  end

end