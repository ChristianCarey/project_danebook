class ProfilePresenter < BasePresenter
  include FriendablePresenter

  def edit_or_friend_link
    is_current_user? ? edit_link : friend_link
  end

  def edit_link
    content_tag :span, class: 'edit no-medium' do 
      link_to 'Edit Profile', edit_user_profile_path(current_user)
    end
  end

  def post_or_photo_form_if_current_user(photo)
    if is_current_user?
      post_or_photo_form(photo)
    end
  end

  private

  def user
    @object.user
  end

  def is_current_user?
    current_user == user
  end
end
