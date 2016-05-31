class TopicsController < ApplicationController


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
    @topic = Topic.new(topic_params)

    if @topic.save
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


end
