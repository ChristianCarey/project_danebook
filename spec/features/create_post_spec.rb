require 'rails_helper'

feature "user creates post" do 

  before do 
    log_in(user)
    create_post(user, post)
  end

  context "with valid input" do 

    let(:post){ build(:post) }
    let(:user){ post.author }

    scenario "the post is added to user's posts" do 
      expect(user.posts.size).to eq(1)
    end

    scenario "shows success message" do 
      expect(page.find('.alert-success')).to be_present
    end

    scenario "redirects to user's timeline" do  
      expect(page.find('#timeline-right')).to be_present
    end
  end

  context "with invalid input" do 

    let(:post){ build(:post, content: "") }
    let(:user){ post.author }

    scenario "shows error message" do 
      expect(page.find('.alert-danger')).to be_present
    end
  end
end