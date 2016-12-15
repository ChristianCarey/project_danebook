class LikingsController < ApplicationController
  before_action :find_liking,          only: [:destroy]
  before_action :require_current_user, only: [:destroy]

  def create
    @likable = extract_likable
    @liking  = new_liking(@likable)
    if @liking.save
      redirect_back(fallback_location: :root)
    else
      flash[:danger] = "You can't like that twice."
      redirect_back(fallback_location: :root)
    end
  end  

  def destroy
    if @liking.destroy
      redirect_back(fallback_location: :root)
    else
      flash[:danger] = "You haven't liked that yet."
      redirect_back(fallback_location: :root)
    end
  end

  private

  def find_liking
    @liking = Liking.find(params[:id])
  end

  def require_current_user
    unless @liking.user == current_user
      flash[:danger] = "You haven't liked that yet."
      redirect_back(fallback_location: :root)
    end
  end

  def extract_likable
    resource, id = request.path.split('/')[1,2]
    resource.singularize.classify.constantize.find(id)
  end

  def new_liking(likable)
    Liking.new(likable_id: likable.id, 
               user_id: current_user.id,
               likable_type: likable.class.to_s)
  end
end