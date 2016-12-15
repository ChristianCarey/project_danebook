class PhotosController < ApplicationController
  before_action :find_photo, only: [:destroy]
  before_action :require_current_user, only: [:destroy]

  def show
  end
  
  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo posted."
      redirect_back(fallback_location: :root)
    else
      flash[:danger] = "Photo could not be uploaded."
      redirect_back(fallback_location: :root)
    end
  end

  def destroy
    if @photo.destroy
      flash[:success]  = "Photo removed."
      redirect_back(fallback_location: :root)
    else
      flash[:danger] = "We can't delete that photo." 
      redirect_back(fallback_location: :root)
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

  def find_photo
    @photo = Photo.find(params[:id])
  end

  def require_current_user
    unless current_user == @photo.author
      flash[:danger] = "Sorry, you're not authorized for that."
      redirect_back_or(user_profile_path(current_user))
    end
  end
end
