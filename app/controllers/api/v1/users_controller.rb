class Api::V1::UsersController < Api::V1::BaseController

  before_action :authenticate_user
  before_action :authorise_user

  def index
    render json: User.all, status: 200
  end

  def show
    render json: User.find(params[:id]), status: 200
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save!
      render json: user, status: 200
    else
      render json: { error: "User is invalid", status: 400 }, status: 400
    end

  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render json: user, status: 200
    else
      render json: { error: "User update failed", status: 400 }, status: 400
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

end