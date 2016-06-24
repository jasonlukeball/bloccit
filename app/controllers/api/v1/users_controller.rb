class Api::V1::UsersController < Api::V1::BaseController

  before_action :authenticate_user
  before_action :authorise_user

  def index
    render json: User.all, status: 200
  end

  def show
    render json: User.find(params[:id]), status: 200
  end

end