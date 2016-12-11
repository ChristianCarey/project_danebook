class CommentsController < ApplicationController
  def create 
    @commentable = extract_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to :back, success: 'Comment created.'
    else
      redirect_to :back, success: "Comment can't be blank."
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def extract_commentable
    resource, id = request.path.split('/')[1,2]
    resource.singularize.classify.constantize.find(id)
  end
end
