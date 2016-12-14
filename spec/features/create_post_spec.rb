require 'rails_helper'

feature "user creates post" do 

  let(:user){ create(:user) }

  before do 
    log_in(user)
    create_post(user, post)
  end

  context "with valid input" do 

    let(:post){ build(:post, author_id: user.id) }
    
    scenario "the post is added to user's posts" do 
      expect(post.author).to eq(user)
    end

    scenario "shows success message" do 
      expect(page.find('.alert-success')).to be_present
    end

    scenario "redirects to user's timeline" do  
      expect(page.find('#timeline-right')).to be_present
    end
  end

  context "with invalid input" do 

    let(:post){ build(:post, author_id: user.id, content: "") }

    scenario "shows error message" do 
      expect(page.find('.alert-danger')).to be_present
    end
  end
end