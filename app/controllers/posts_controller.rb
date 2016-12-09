class PostsController < ApplicationController
  before_action :find_user,            only: [:create, :destroy]
  before_action :require_current_user, only: [:create, :destroy]

  def index
    if params[:user_id]
      find_user
      @posts = @user.timeline
      render :user_posts
    else
      @posts = Post.timeline
    end
  end

  def create
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

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def require_current_user
    unless current_user == @user
      flash[:danger] = "Sorry, you're not authorized for that."
      redirect_back_or(user_profile_path(@user))
    end
  end
end
