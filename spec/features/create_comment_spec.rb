require 'rails_helper'

feature "user creates comment" do 

  let(:user)   { create(:user) }
  let(:post)   { build(:post) } 
  
  before do 
    log_in(user)
    create_post(user, post)
    fill_in 'comment_content', with: comment.content
    click_button "Comment"
  end

  context "with correct input" do 

    let(:comment){ build(:comment) }

    scenario "shows success message" do 
      expect(page.find('.alert-success')).to be_present
    end

    scenario "the comment is added the user's comments" do
      expect(user.comments.size).to eq(1)
    end
  end

  context "with incorrect input" do 

    let(:comment){ build(:comment, content: "") }

    scenario "shows error message" do 
      expect(page.find('.alert-danger')).to be_present
    end

    scenario "the comment is not added the user's comments" do
      expect(user.comments.size).to eq(0)
    end    
  end


end