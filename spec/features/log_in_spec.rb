require 'rails_helper'

feature "user logs in" do 

  before do
    log_in(user)
  end

  context "with valid input" do 

    let(:user){ create(:user) }

    scenario "shows success message" do
      expect(page.find('.alert-success')).to be_present
    end

    scenario "redirects to user's timeline" do  
      expect(page.find('#timeline-right')).to be_present
    end
  end

  context "with invalid input" do 

    let(:user){ build(:user, password: 'wrong') }

    scenario "shows error message" do 
      expect(page.find('.alert-danger')).to be_present
    end

    scenario "redirects to login path" do 
      expect(page.find('#main-login-form')).to be_present
    end
  end
end