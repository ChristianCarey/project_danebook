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
    current_user.friend_of?(user) ? remove_friend_link : add_friend_link
  end

  private

  def user
    @object.user
  end

  def add_friend_link
    content_tag :span, class: 'btn btn-primary friend-button' do 
      link_to 'Add Friend', user_friendships_path(user), method: :post
    end
  end

  def remove_friend_link
    # TODO can I get the right liking without making this query?
    friendship = Friendship.where(user_id: current_user.id, friend_id: user.id).first
    content_tag :span, class: 'btn btn-primary friend-button' do 
      link_to 'Unfriend', friendship_path(friendship), method: :delete
    end
  end
end
