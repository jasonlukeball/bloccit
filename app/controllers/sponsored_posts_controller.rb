class SponsoredPostsController < ApplicationController


  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end


  def new
    @sponsored_post = SponsoredPost.new
    @topic = Topic.find(params[:topic_id])
  end


  def create
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body  = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    @sponsored_post.topic = @topic

    if @sponsored_post.save
      flash[:notice] = "Sponsored Post saved successfully!"
      redirect_to [@topic, @sponsored_post]
    else
      flash[:error] = "Error! Sponsored Post could not be saved! Please try again"
      render :new
    end
  end


  def edit
    @sponsored_post = SponsoredPost.find(params[:id])
  end


  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.update_attributes(title: params[:sponsored_post][:title], body: params[:sponsored_post][:body], price: params[:sponsored_post][:price] )

    if @sponsored_post.save
      flash[:notice] = "Sponsored Post successfully updated!"
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash[:noterrorice] = "Error updating Sponsored Post! Please try again!"
      render :edit
    end

  end


  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])

    if @sponsored_post.destroy
      flash[:notice] = "Sponsored Post successfully deleted!"
      redirect_to @sponsored_post.topic
    else
      flash[:notice] = "Error: Sponsored Post could not be deleted! Please try again!"
      render :show
    end

  end

end
