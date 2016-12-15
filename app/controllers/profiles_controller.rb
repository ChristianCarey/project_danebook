class ProfilesController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :require_current_user, only: [:edit, :update]
  def new
  end

  def show
    @profile = @user.profile
  end

  def edit
    @profile = @user.profile
  end

  def update    
    if @user.profile.update(profile_params)
      flash[:success] = "Profile updated!"
      redirect_to user_profile_path(@user)
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:user_id, :birthday, :college, :hometown, :current_location, :phone, :about_me, :tagline)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def require_current_user
    unless current_user.id.to_s == params[:user_id]
      flash[:danger] = "Sorry, you're not authorized to do that."
      redirect_back_or(@user.profile)
    end
  end
end
