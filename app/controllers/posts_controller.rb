class PostsController < ApplicationController
  before_action :find_post,            only: [:destroy]
  before_action :require_current_user, only: [:destroy]


  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      respond_to do |format|
        format.html do 
          flash[:success] = "Post created!"
          redirect_back(fallback_location: :root)
        end

        format.js do 
          @activity = @post
          render 'shared/create'
        end
      end
    else
      flash[:danger] = "Post can't be blank."
      redirect_back(fallback_location: :root)
    end
  end

  def destroy
    if @post.destroy
      respond_to do |format|
        format.html do 
          flash[:success]  = "Post removed."
          redirect_back(fallback_location: :root)
        end

        format.js do 
          @deletable = @post
          render 'shared/destroy'
        end
      end
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
