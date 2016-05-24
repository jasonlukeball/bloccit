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
    @topic = Topic.new
    @topic.name = params[:topic][:name]
    @topic.description = params[:topic][:description]

    if @topic.save
      flash[:notice] = "Topic successfully created!"
      redirect_to @topic
    else
      flash[:error] = "Topic could not be created! Please try again"
      render :new
    end
  end


  def edit
    @topic = Topic.find(params[:id])
  end


  def update
    @topic = Topic.find(params[:id])
    @topic.update_attributes(name: params[:topic][:name], description: params[:topic][:description], public: params[:topic][:public])

    if @topic.save
      flash[:notice] = "Topic successfully updated!"
      redirect_to @topic
    else
      flash[:error] = "Topic could not be updated, please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was successfully deleted!"
      redirect_to topics_path
    else
      flash[:error] = "Topic could not be deleted, please try again."
      render @topic
    end

  end


end
