class FriendshipsController < ApplicationController
  
  def index
    @user        =  User.find(params[:user_id])
    @friendships = @user.friendships
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    if @friendship.save
      redirect_to :back, success: "Friend added."
    else
      redirect_to :back, danger: "Can't add friend again."
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    require_current_user
    @friendship.destroy
    if @friendship.destroy
      redirect_to :back
    else
      redirect_to :back, danger: "You haven't friended them yet."
    end
  end  

  def require_current_user
    unless @friendship.user == current_user
      redirect_to :back, danger: "That's not your friendship."
    end
  end
end
