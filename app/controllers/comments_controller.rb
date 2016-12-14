class CommentsController < ApplicationController
  def create 
    @commentable = extract_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      flash[:success] = 'Comment created.'
      redirect_to :back
    else
      flash[:danger] = "Comment can't be blank."
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    require_current_user
    if @comment.destroy
      flash[:success]  = "Comment removed."
      redirect_to :back
    else
      flash[:danger] = "We can't delete that comment." 
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def extract_commentable
    resource, id = request.path.split('/')[1,2]
    resource.singularize.classify.constantize.find(id)
  end

  def require_current_user
    unless @comment.author == current_user
      redirect_to :back, danger: "That's not yours to delete."
    end
  end
end
