require 'rails_helper'

feature "user edits profile" do 

  let(:user){ create(:user) }

  before do 
    log_in(user)
    visit edit_user_profile_path(user)
    fill_in 'profile_birthday',         with: profile.birthday
    fill_in 'profile_college',          with: profile.college
    fill_in 'profile_hometown',         with: profile.hometown
    fill_in 'profile_current_location', with: profile.current_location
    fill_in 'profile_phone',            with: profile.phone
    fill_in 'profile_tagline',          with: profile.tagline
    fill_in 'profile_about_me',         with: "test"
    click_button 'Save Changes'
  end

  context "with valid input" do 
    
    let(:profile){ build(:profile, user_id: user.id) }
    
    scenario "shows success message" do 
      expect(page.find('.alert-success')).to be_present
    end

    scenario "redirects to about page" do 
      expect(page.find('header#profile-header')).to have_content("About")
    end

    scenario "updates user profile" do 
      expect(page.find('.about-me')).to have_content('test')
    end
  end
end