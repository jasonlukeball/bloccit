class Api::V1::CommentsController < Api::V1::BaseController

  before_action :authenticate_user, except: [:index, :show]
  before_action :authorise_user, except: [:index, :show]

  def index
    render json: Comment.all, status: 200
  end

  def show
    render json: Comment.find(params[:id]), status: 200
  end

end