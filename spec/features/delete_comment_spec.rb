require 'rails_helper'

feature "user deletes comment" do 

  let(:user){ create(:user) }
  let(:post){ build(:post) }
  let(:comment){ build(:comment) }

  before do
    log_in(user)
    create_post(user, post)
    fill_in 'comment_content', with: comment.content
    click_button "Comment"
    within ".comment-footer" do 
      click_link 'Delete'
    end
  end

  scenario "the user no longer has the comment" do 
    expect(user.comments.size).to eq(0)
  end

  scenario "shows success message" do 
    expect(page.find('.alert-success')).to be_present
  end

  scenario "redirects to user's timeline" do  
    expect(page.find('#timeline-right')).to be_present
  end
end
  