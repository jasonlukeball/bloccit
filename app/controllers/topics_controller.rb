class TopicsController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]
  before_action :authorise_user_create_delete, only: [:new, :create, :destroy]
  before_action :authorise_user_edit_update, only: [:edit, :update]


  def index
    @topics = Topic.all
  end


  def show
    @topic = Topic.find(params[:id])
  end


  def new
    @topic = Topic.new
  end


  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      @topic.labels = Label.update_labels(params[:topic][:labels])
      flash[:notice] = "Topic successfully created!"
      redirect_to @topic
    else
      flash[:alert] = "Topic could not be created! Please try again"
      render :new
    end
  end


  def edit
    @topic = Topic.find(params[:id])
  end


  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      @topic.labels = Label.update_labels(params[:topic][:labels])
      flash[:notice] = "Topic successfully updated!"
      redirect_to @topic
    else
      flash[:alert] = "Topic could not be updated, please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was successfully deleted!"
      redirect_to topics_path
    else
      flash[:alert] = "Topic could not be deleted, please try again."
      render @topic
    end

  end


  private

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def authorise_user_create_delete
    unless current_user.admin?
      flash[:alert] = "Sorry, you must be an admin to do that!"
      redirect_to topics_path
    end
  end

  def authorise_user_edit_update
    unless current_user.moderator? || current_user.admin?
      flash[:alert] = "Sorry, you must be a moderator or an admin to do that!"
      redirect_to topics_path
    end
  end


end
