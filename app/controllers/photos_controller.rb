class PhotosController < ApplicationController
  before_action :find_photo, only: [:show, :destroy]
  before_action :require_current_user, only: [:destroy]

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos
    render :user_photos_index
  end

  def show
  end
  
  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      respond_to do |format|
        format.html do 
          flash[:success] = "Photo posted."
          redirect_back(fallback_location: :root)
        end

        format.js do
          @activity = @photo
          render 'shared/create'
        end
      end
    else
      flash[:danger] = "Photo could not be uploaded."
      redirect_back(fallback_location: :root)
    end
  end

  def destroy
    if @photo.destroy
      respond_to do |format|
        format.html do 
          flash[:success]  = "Photo removed."
          redirect_back(fallback_location: :root)
        end

        format.js do 
          @deletable = @photo
          render 'shared/destroy'
        end
      end
    else
      respond_to do |format|
        forrmat.html do 
          flash[:danger] = "We can't delete that photo." 
          redirect_to user_activities_path(current_user)
        end

        format.js do 
          @deletable = @photo
          render 'shared/destroy'
        end
      end
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
