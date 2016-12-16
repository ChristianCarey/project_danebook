class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy]
  before_action :require_current_user, only: [:destroy]
  def create 
    @commentable = extract_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      send_commented_email
      flash[:success] = 'Comment created.'
      redirect_back(fallback_location: :root)
    else
      flash[:danger] = "Comment can't be blank."
      redirect_back(fallback_location: :root)
    end
  end

  def destroy
    if @comment.destroy
      flash[:success]  = "Comment removed."
      redirect_back(fallback_location: :root)
    else
      flash[:danger] = "We can't delete that comment." 
      redirect_back(fallback_location: :root)
    end
  end

  private

  def send_commented_email
    Comment.delay.send_commented_email(
      commenter_id: @comment.author.id,
      commented_id: @commentable.author.id,
      comment_id:   @comment.id
    )
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def extract_commentable
    resource, id = request.path.split('/')[1,2]
    resource.singularize.classify.constantize.find(id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def require_current_user
    unless @comment.author == current_user
      flash[:danger] = "That's not yours to delete."
      redirect_back(fallback_location: :root)
    end
  end
end
