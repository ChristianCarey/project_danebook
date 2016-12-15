require 'rails_helper'

RSpec.describe LikingsController, type: :controller do

  let(:user){ create(:user) }
  let(:post){ create(:post)}

  before do 
    request.cookies[:auth_token] = user.auth_token
  end

  describe "POST #create" do 

    before do 
      process :create, params: { post_id: post.id }
    end

    context "new like" do

      it "adds the likable to the user's likes" do 
        expect(user.likes?(post)).to be true
      end
    end

    context "already liked" do 

      it "does not add the like to the user's likes" do 
        expect do 
          process :create, params: { post_id: post.id }
        end.to change(user.liked_posts, :count).by(0)
      end
    end
  end

  describe "DELETE #destroy" do 

    context "correct user" do 

      let(:liking) { create(:liking, user_id: user.id) }

      before { liking }

      it "reduces the users likings by one" do 
        expect do 
          process :destroy, params: { id: liking.id }
        end.to change(user.likings, :count).by(-1)
      end
    end

    context "incorrect user" do 

      let(:liking) { create(:liking)}

      before { liking }
      
      it "does not delete any likings" do 
        expect do 
          process :destroy, params: { id: liking.id }
        end.to change(Comment, :count).by(0)
      end
    end
  end
end
