require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user){ create(:user) }
  let(:post){ create(:post)}

  before do 
    request.cookies[:auth_token] = user.auth_token
  end

  describe "POST #create" do 

    context "signed in user" do 
      
      context "success" do

        it "creates a comment on the user" do 
          expect do 
            process :create, params: { post_id: post.id, comment: attributes_for(:comment) }
          end.to change(user.comments, :count).by(1)
        end
      end

      context "failure" do 

        it "does not create a comment" do 
          expect do 
            process :create, params: { post_id: post.id, comment: attributes_for(:comment, content: "") }
          end.to change(user.comments, :count).by(0)
        end
      end
    end

    context "signed out user" do 

      before do 
        request.cookies.delete(:auth_token)
      end

      it "redirects user to the sign up path" do 
        process :create, params: { post_id: post.id, comment: attributes_for(:comment) }
        expect(response).to redirect_to(new_user_path)
      end
    end
  end

  describe "DELETE #destroy" do 

    context "correct user" do 

      let(:comment) { create(:comment, author_id: user.id) }

      before { comment }

      it "reduces the users comments by one" do 
        expect do 
          process :destroy, params: { id: comment.id }
        end.to change(user.comments, :count).by(-1)
      end
    end

    context "incorrect user" do 

      let(:comment) { create(:comment)}

      before { comment }
      
      it "does not delete any comments" do 
        expect do 
          process :destroy, params: { id: comment.id }
        end.to change(Comment, :count).by(0)
      end
    end
  end
end
