class UsersController < ApplicationController

  def new
    @user = User.new
    @user.name = params[:user][:name]     if params[:user].present?
    @user.email = params[:user][:email]   if params[:user].present?
  end

  def confirm
  end

  def create
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Reddit #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    else
      flash[:alert] = "There was an error creating your account, please try again!"
      render :new
    end
  end



end
