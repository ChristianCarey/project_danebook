class ActivitiesController < ApplicationController
  def index
    @photo = params[:photo]
    if params[:user_id]
      @user = User.find(params[:user_id])
      @activities = @user.activities
      render :user_activities_index
    else
      @activites = Activity.all
    end
  end
end