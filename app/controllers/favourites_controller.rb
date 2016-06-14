class FavouritesController < ApplicationController

  before_action :require_sign_in


  def create
    post = Post.find(params[:post_id])
    favourite = current_user.favourites.build(post: post)
    if favourite.save
      flash[:notice] = "Post Favourited!"
    else
      flash[:alert] = "Favouriting Failed! Please try again!"
    end
    redirect_to([post.topic, post])
  end


  def destroy
    post = Post.find(params[:post_id])
    favourite = current_user.favourites.find(params[:id])
    if favourite.destroy
      flash[:notice] = "Post Favourite Deleted!"
      redirect_to([post.topic, post])
    else
      flash[:alert] = "Error Deleting Favourite! Please try again!"
    end
  end

end
