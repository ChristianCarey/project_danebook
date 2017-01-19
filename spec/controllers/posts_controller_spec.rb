require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:user) { create(:user) }

  before do 
    request.cookies[:auth_token] = user.auth_token
  end

  describe "POST #create" do 

    context "success" do 

      before do 
        process :create, params: { post: attributes_for(:post) }
      end
      
      it "creates a post on the current user" do 
        expect(user.posts).to include(Post.last)
      end

      it "redirects back" do 
        expect(response).to redirect_to(:root)
      end
    end

    context "failure" do 

      before do 
        process :create, params: { post: attributes_for(:post, content: "") }
      end

      it "does not create a post" do 
        expect(user.posts).to be_empty
      end

      it "redirects back" do 
        expect(response).to redirect_to(:root)
      end
    end
  end

  describe "DELETE #destroy" do 

    context "correct user" do 
      
      let(:post) { create(:post, author_id: user.id) }

      before { post }

      it "removes the post from the user's posts" do 
        expect do 
          process :destroy, params: { id: post.id }
        end.to change(user.posts, :count).by(-1)
      end
    end

    context "incorrect user" do 

      let(:post) { create(:post) }

      before { post }

      it "does not delete any posts" do 
        expect do 
          process :destroy, params: { id: post.id }
        end.to change(Post, :count).by(0)
      end
    end
  end
end
