class ProfilesController < ApplicationController
  before_action :require_current_user, only: [:edit, :update]
  def new
  end

  def show
    @user    = User.find(params[:user_id])
    @profile = @user.profile
  end

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:user_id])

    if @user.profile.update(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to 
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:user_id, :birthday, :college, :hometown, :current_location, :phone, :about_me, :tagline)
  end

  def require_current_user
    unless current_user.id.to_s == params[:user_id]
      flash[:danger] = "Sorry, you're not authorized to do that."
      redirect_back_or(root_path)
    end
  end
end
