require 'rails_helper'

feature "user deletes post" do 

  let(:user){ create(:user) }
  let(:post){ build(:post) }

  before do
    log_in(user)
    create_post(user, post)
    within "ul.post-actions" do 
      click_link 'Delete'
    end
  end

  scenario "the user no longer has the post" do 
    expect(user.posts.size).to eq(0)
  end

  scenario "shows success message" do 
    expect(page.find('.alert-success')).to be_present
  end

  scenario "redirects to user's timeline" do  
    expect(page.find('#timeline-right')).to be_present
  end
end
  