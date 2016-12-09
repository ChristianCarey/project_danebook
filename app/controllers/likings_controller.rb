class LikingsController < ApplicationController
  def create
    @likable = extract_likable
    if current_user.like(@likable)
      redirect_to :back
    else
      flash[:danger] = "You can't like this twice."
      redirect_to :back
    end
  end  

  private

  def extract_likable
    resource, id = request.path.split('/')[1,2]
    resource.singularize.classify.constantize.find(id)
  end
end
