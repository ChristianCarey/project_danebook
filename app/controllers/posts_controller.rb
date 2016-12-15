class PostsController < ApplicationController
  before_action :find_post,            only: [:destroy]
  before_action :require_current_user, only: [:destroy]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.timeline.limit(10)
      render :user_posts
    else
      @posts = Post.timeline.limit(10)
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      # TODO does not work with path, only url?
      redirect_to user_posts_path(current_user)
    else
      # TODO cannot render because instance variables get lost
      flash[:danger] = "Post can't be blank."
      redirect_to user_posts_url(current_user)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to user_posts_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def require_current_user
    unless current_user == @post.author
      flash[:danger] = "Sorry, you're not authorized for that."
      redirect_back_or(user_profile_path(current_user))
    end
  end
end
