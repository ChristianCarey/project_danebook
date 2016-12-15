require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  let(:user) { create(:user) }
  let(:profile) { user.profile }

  describe "PATCH update" do 

    context "correct user" do 

      before do 
        request.cookies[:auth_token] = user.auth_token
      end

      context "success" do 

        let(:new_tagline){ "test" }

        before do 
          process :update, params: { user_id: user.id, profile: attributes_for(:profile, tagline: new_tagline) }
        end
        
        it "updates the profile" do 
          profile.reload
          expect(profile.tagline).to eq(new_tagline)
        end

        it "redirects to that profile's show page" do
          expect(response).to redirect_to(user_profile_path(user))
        end
      end

      context "failure" do 

        let(:new_birthday){ Date.today + 1 }

        before do 
          process :update, params: { user_id: user.id, profile: attributes_for(:profile, birthday: new_birthday) }
        end

        it "does not update a profile" do 
          old_birthday = profile.birthday
          profile.reload
          expect(profile.birthday).to eq(old_birthday)
        end

        it "does not redirect" do 
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context "not correct user" do 

      let(:other_user){ create(:user) }
      let(:new_tagline){ "test" }

      before do 
        request.cookies[:auth_token] = other_user.auth_token
        process :update, params: { user_id: user.id, profile: attributes_for(:profile, tagline: new_tagline) }
      end

      it "redirects to profile show page" do 
        expect(response).to redirect_to(user.profile)
      end
    end
  end
end
