class LikingsController < ApplicationController
  def create
    @likable = extract_likable
    if current_user.like(@likable)
      redirect_to :back
    else
      flash[:danger] = "You can't like that twice."
      redirect_to :back
    end
  end  

  def destroy
    @liking = Liking.find(params[:id])
    require_current_user
    if @liking.destroy
      redirect_to :back
    else
      redirect_to :back, danger: "You haven't liked that yet."
    end
  end

  private

  def require_current_user
    unless @liking.user == current_user
      redirect_to :back, danger: "That's not your like."
    end
  end

  def extract_likable
    resource, id = request.path.split('/')[1,2]
    resource.singularize.classify.constantize.find(id)
  end
end