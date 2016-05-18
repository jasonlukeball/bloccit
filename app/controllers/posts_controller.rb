class PostsController < ApplicationController

  def index
    @posts = Post.all
    @posts = @posts.each do |post|
      if post.id % 5 == 0
        post.title = "SPAM"
        post.save
      end
    end
    @posts = Post.all
  end

  def new
  end

  def edit
  end

end
