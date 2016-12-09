class PostsController < ApplicationController
  def index
    if params[:user_id]
      @user  = User.find(params[:user_id])
      @posts = @user.timeline
      render :user_posts
    else
      @posts = Post.timeline
    end
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      # TODO does not work with path, only url?
      redirect_to user_posts_url(@user)
    else
      # TODO cannot render because instance variables get lost
      redirect_to user_posts_url(@user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
