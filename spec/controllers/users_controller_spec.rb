require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST create" do 

    context "success" do 
      it "creates a new user" do 
        expect do
          process :create, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it "redirects to that user's profile's edit page" do
        process :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to(edit_user_profile_path(User.last))
      end
    end

    context "failure" do 

      it "does not create a user" do 
        expect do 
          process :create, params: { user: attributes_for(:user, password: 'Wrong') }
        end.to change(User, :count).by(0)
      end

      it "does not redirect" do 
        process :create, params: { user: attributes_for(:user, password: 'Wrong') }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
