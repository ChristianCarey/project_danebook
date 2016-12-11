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
end
