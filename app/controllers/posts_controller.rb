class PostsController < ApplicationController
  before_action :find_post,            only: [:destroy]
  before_action :require_current_user, only: [:destroy]

  def index
    @photo = params[:photo]
    if params[:user_id]
      @user = User.find(params[:user_id])
      # TODO paginate
      @posts = @user.timeline
      render :user_posts
    else
      # TODO paginate
      # TODO this will not do. Activities?
      @posts = Photo.timeline + Post.timeline
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      track_activity
      flash[:success] = "Post created!"
      redirect_to user_posts_path(current_user)
    else
      flash[:danger] = "Post can't be blank."
      redirect_to user_posts_url(current_user)
    end
  end

  def destroy
    if @post.destroy
      flash[:success]  = "Post removed."
      redirect_back(fallback_location: :root)
    else
      flash[:danger] = "We can't delete that post." 
      redirect_back(fallback_location: :root)
    end
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
