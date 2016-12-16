class PhotoPresenter < BasePresenter
  include LikablePresenter
  include CommentablePresenter
  include DeletablePresenter

  def profile_photo_link
    unless current_user.profile_photo == photo
      link_to "Make this your profile photo", profile_photos_path(id: photo), method: :post
    end
  end

  private

  def photo
    @object
  end
end
