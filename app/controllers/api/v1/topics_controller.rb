class Api::V1::TopicsController < Api::V1::BaseController

  before_action :authenticate_user, except: [:index, :show]
  before_action :authorise_user, except: [:index, :show]

  def index
    render json: Topic.all, status: 200
  end

  def show
    render :json => Topic.find(params[:id]), :include => [:posts], status: 200
  end

end