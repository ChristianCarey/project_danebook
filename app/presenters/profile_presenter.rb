class ProfilePresenter < BasePresenter


  def edit_or_friend_link
    current_user == user ? edit_link : friend_link
  end

  def edit_link
    content_tag :span, class: 'edit no-medium' do 
      link_to 'Edit Profile', edit_user_profile_path(current_user)
    end
  end

  def friend_link
    content_tag :span, class: 'btn btn-primary friend-button' do 
      link_to 'Add Friend', user_friendships_path(user), method: :post
    end
  end

  private

  def user
    @object.user
  end
end
