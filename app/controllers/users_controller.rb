class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.update_attributes(
      name: params[:user][:name],
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )

    if @user.save
      flash[:notice] = "Welcome to Reddit #{@user.name}!"
      redirect_to root_path
    else
      flash[:alert] = "There was an error creating your account, please try again!"
      render :new
    end
  end

  def confirm
    @user = User.new
    @user.update_attributes(
      name: params[:user][:name],
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )
  end

end
