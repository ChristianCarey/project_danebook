class FriendshipsController < ApplicationController
  before_action :find_friendship,      only: [:destroy]
  before_action :require_current_user, only: [:destroy]
  
  def index
    @user        =  User.find(params[:user_id])
    @friendships = @user.friendships
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    if @friendship.save
      flash[:success] = "Friend added."
      redirect_back(fallback_location: :root)
    else
      flash[:danger] = "Can't add that person as a friend."
      redirect_back(fallback_location: :root)
    end
  end

  def destroy
    if @friendship.destroy
      flash[:success] = "Friend removed."
      redirect_back(fallback_location: :root)
    else
      flash[:danger] = "They're not your friend."
      redirect_back(fallback_location: :root)
    end
  end  

  private

  def find_friendship
    @friendship = Friendship.find(params[:id])
  end

  def require_current_user
    unless @friendship.user == current_user || @friendship.friend == current_user
      flash[:danger] = "You can't do that."
      redirect_back(fallback_location: :root)
    end
  end
end
