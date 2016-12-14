require 'rails_helper'

feature "user signs up" do 

  before do 
    visit new_user_path
    sign_up(user)
  end

  context "with valid input" do 
    
    let(:user){ build(:user) }

    scenario "shows success message" do 
      expect(page.find('.alert-success')).to be_present
    end
  end


  context "with invalid input" do 

    let(:user){ build(:user, password: 'wrong') }

    scenario "shows error message" do 
      expect(page.find('.alert-danger')).to be_present
    end
  end

end