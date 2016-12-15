require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do

  let(:user)        { create(:user) }
  let(:second_user) { create(:user) }

  before do 
    request.cookies[:auth_token] = user.auth_token
  end

  describe "POST #create" do 

    before do 
      process :create, params: { user_id: second_user.id }
    end

    context "new friend" do 

      it "adds a friend to the user" do 
        expect(user.friends).to include(second_user)
      end
    end

    context "already friended" do 

      it "does not add a friend to the user" do 
        expect do 
          process :create, params: { user_id: second_user.id }
        end.to change(user.friends, :count).by(0)
      end
    end
  end

  describe "DELETE #destroy" do 

    context "other user is a friend" do 

      before do 
        process :create,  params: { user_id: second_user.id }
        process :destroy, params: { id: Friendship.last.id }
      end

      it "removes the other user from the user's friends" do 
        expect(user.friends).to_not include(second_user)
      end
    end

    context "other user is not a friend" do 
      
      let(:third_user) { create(:user) }
      let(:other_friendship) { create(:friendship) }

      before do 
        other_friendship.user = second_user
        other_friendship.friend = third_user
        other_friendship.save
        process :destroy, params: { id: other_friendship.id }
      end

      it "does not remove the other user from the user's friends" do 
        expect(second_user).to be_friend_of(third_user)
      end
    end
  end
end
