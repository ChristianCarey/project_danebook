class ActivitiesController < ApplicationController
  def index
    @photo = params[:photo]
    if params[:user_id]
      @user = User.find(params[:user_id])
      @activities = @user.timeline.paginate(page: params[:page], per_page: 10)
      render :user_activities_index
    else
      @activities = Activity.timeline.paginate(page: params[:page], per_page: 10)
    end
  end
end