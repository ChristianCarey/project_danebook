class ProfilePhotosController < ApplicationController
  before_action :find_photo
  before_action :require_current_user, only: [:destroy]
  
  def create
    current_user.profile_photo = @photo
    if current_user.save 
      flash[:success] = "Profile photo updated."
      redirect_back(fallback_location: :root)
    else
      flash[:error] = "Could not update profile photo."
      redirect_back(fallback_location: :root)
    end  
  end

  def destroy
    # TODO don't destroy profile!
    if @profile.destroy
      flash[:success] = "Profile photo deleted."
      redirect_back(fallback_location: :root)
    else
      flash[:error] = "Could not delete profile photo."
      redirect_back(fallback_location: :root)
    end 
  end

  private

  def find_photo
    @photo = Photo.find(params[:id])
  end

  def require_current_user
    unless current_user = @photo.profiler
      flash[:error] = "You can do that."
      redirect_back(fallback_location: :root)
    end
  end
end
